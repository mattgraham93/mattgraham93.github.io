WITH weeks AS (
    SELECT DISTINCT
        ds
    FROM "TABLE1"
    WHERE
        DATE(ds) = DATE_TRUNC('week', DATE(ds))
        AND YEAR(DATE(ds)) >= 2021

),
amenity_sp AS (
    SELECT
        ds a_ds,
        bl_id,
        fl_id,
        rm_id,
        name rm_name,
        rm_cat,
        rm_group,
        rm_type,
        -- fb_reservable_id,
        CAST(SUM(area) AS INT) area_used,
        LAG(CAST(SUM(area) AS INT)) OVER (
            PARTITION BY
                bl_id,
                fl_id,
                rm_id,
                name,
                rm_cat,
                rm_group,
                rm_type
            ORDER BY
                ds ASC
        ) last_area,
        'amenity' source
    FROM TABLE2
    WHERE
        ds IN (
            SELECT
                ds
            FROM weeks
        )
        AND rm_cat LIKE 'AMENITY'
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8
),
event_sp AS (
    SELECT
        ds e_ds,
        bl_id,
        fl_id,
        rm_id,
        name rm_name,
        rm_cat,
        rm_group,
        rm_type,
        fb_reservable_id,
        CAST(SUM(area) AS INT) area_used,
        LAG(CAST(SUM(area) AS INT)) OVER (
            PARTITION BY
                bl_id,
                fl_id,
                rm_id,
                name,
                rm_cat,
                rm_group,
                rm_type
            ORDER BY
                ds ASC
        ) last_area,
        'event' source
    FROM TABLE2
    WHERE
        ds IN (
            SELECT
                ds
            FROM weeks
        )
        AND fb_reservable_id LIKE '%EVENT%'

    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9
),
rooms AS (
    SELECT
        COALESCE(DATE(ev.e_ds), DATE(am.a_ds)) r_ds,
        COALESCE(ev.rm_id, am.rm_id) rm_id,
        COALESCE(ev.bl_id, am.bl_id) bl_id,
        COALESCE(ev.fl_id, am.fl_id) fl_id,
        COALESCE(ev.rm_name, am.rm_name) rm_name,
        COALESCE(ev.rm_cat, am.rm_cat) rm_cat,
        COALESCE(ev.rm_type, am.rm_type) rm_type,
        COALESCE(ev.fb_reservable_id, am.rm_cat) event_room,
        COALESCE(ev.source, am.source) source,
        CASE
            WHEN (
                COALESCE(am.rm_cat, ev.rm_cat) LIKE 'AMENITY' AND COALESCE(
                    ev.source,
                    am.source
                ) LIKE 'amenity'
            ) THEN 'amenity-only'
            WHEN (
                COALESCE(am.rm_cat, ev.rm_cat) NOT LIKE 'AMENITY' AND COALESCE(
                    ev.source,
                    am.source
                ) LIKE 'event'
            ) THEN 'event-only'
            ELSE 'event-amenity'
        END amenity_flag,
        COALESCE(SUM(ev.area_used), SUM(am.area_used)) area_used,
        COALESCE(SUM(ev.last_area), SUM(am.last_area)) last_area
    FROM event_sp ev
    FULL JOIN amenity_sp am
        ON ev.rm_id = am.rm_id
        AND ev.bl_id = am.bl_id
        AND ev.e_ds = am.a_ds
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10
),
bl_fl AS (
    SELECT DISTINCT
        -- ds,
        regn_id,
        site_id site,
        afo.bl_id,
        afo.fl_id,
        building_name,
        building_use,
        DATE(full_date) full_date,
        current_building_status,
        floor_status,
        -- SUM(occupancy) bldg_occ, -- sum since across multiple floors
        -- SUM(total_desks) bldg_cap, -- sum since across multiple floors
        -- SUM(total_seated) bldg_hc, -- allocated to desk/planning group, loose "headcount"; likely to be higher than total_desks. sum since across multiple floors
        DATE_TRUNC(
            'month',
            CAST(COALESCE(MIN(start_date), MIN(ready_date)) AS DATE)
        ) floor_date,
        DATE_TRUNC(
            'month',
            CAST(
                COALESCE(CAST(MAX(floor_close_date) AS DATE), MAX(date_end)) AS DATE
            )
        ) close_date
    FROM TABLE3 afo
    FULL JOIN (
        SELECT DISTINCT
            bl_id,
            MAX(date_end) date_end
        FROM TABLE2
        WHERE
            is_active
            AND is_valid_lease
            AND ds = (
                SELECT
                    MAX(ds)
                FROM "TABLE2$partitions"
            )
        GROUP BY
            1
    ) cstar
        ON cstar.bl_id = afo.bl_id
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE3$partitions"
        )
        AND full_date IN (
            SELECT
                *
            FROM weeks
        )
        AND data_center_flag LIKE 'N'
        AND floor_status NOT IN ('CLOSED', 'PENDING')

    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9
),
bl_fl_rm AS (
    SELECT DISTINCT
        CONCAT(bf.bl_id, bf.fl_id, r.rm_id, CAST(bf.full_date AS VARCHAR)) sw_id,
        rm_id,
        r.bl_id,
        r.fl_id,
        rm_name,
        rm_cat,
        rm_type,
        event_room,
        amenity_flag,
        source,
        area_used,
        last_area,
        regn_id,
        site,
        building_name,
        building_use,
        current_building_status,
        floor_status,
        floor_date,
        close_date,
        bf.full_date
    FROM rooms r
    INNER JOIN bl_fl bf
        ON bf.bl_id = r.bl_id
        AND bf.fl_id = r.fl_id
        AND bf.full_date = r.r_ds
    WHERE
        rm_id IS NOT NULL
),
cj AS (
    SELECT DISTINCT
        bl_id,
        fl_id,
        rm_id,
        ds
    FROM bl_fl_rm
    CROSS JOIN weeks
),
matched AS (
    SELECT
        CONCAT(cj.bl_id, cj.fl_id, cj.rm_id, cj.ds) sw_id, -- sw_id = space/week id where space = building/floor/room and week = rooms.ds
        cj.bl_id,
        cj.fl_id,
        cj.rm_id,
        DATE(cj.ds) ds
    FROM cj
    INNER JOIN bl_fl_rm bw
        ON CONCAT(cj.bl_id, cj.fl_id, cj.rm_id, cj.ds) = bw.sw_id
),
unmatched AS (
    SELECT
        CONCAT(cj.bl_id, cj.fl_id, cj.rm_id, cj.ds) sw_id, -- sw_id = space/week id where space = building/floor/room and week = rooms.ds
        cj.bl_id,
        cj.fl_id,
        cj.rm_id,
        DATE(cj.ds) ds
    FROM cj
    WHERE
        NOT EXISTS (
            SELECT
                sw_id
            FROM matched m
            WHERE
                CONCAT(cj.bl_id, cj.fl_id, cj.rm_id, cj.ds) = m.sw_id
        )
),
long AS (
    SELECT
        *
    FROM unmatched

    UNION ALL

    SELECT
        *
    FROM matched
)
SELECT
    l.ds,
    l.sw_id,
    l.rm_id,
    l.bl_id,
    l.fl_id,
    bfr.rm_name,
    bfr.rm_cat,
    bfr.rm_type,
    bfr.event_room,
    bfr.amenity_flag,
    bfr.source,
    bfr.area_used,
    bfr.last_area,
    bfr.regn_id,
    bfr.site,
    bfr.building_name,
    bfr.building_use,
    bfr.current_building_status,
    bfr.floor_status,
    bfr.floor_date,
    bfr.close_date
FROM long l
FULL JOIN bl_fl_rm bfr
    ON l.sw_id = bfr.sw_id
ORDER BY
    2, 3, 4, 5 ASC
