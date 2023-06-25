WITH bl_fl AS (
    SELECT
        regn_id,
        site_id,
        campus,
        bl_id,
        -- bl_fl,
        current_building_status,
        address1,
        -- floor_status,
        ROUND(SUM(area_rentable)) rsf,
        ROUND(SUM(area_manual_nia)) rsf2, -- rely on manual entry since from costar
        ROUND(SUM(area_usable)) usf,
        ROUND(SUM(area_manual_gia)) usf2,
        ROUND(SUM(area_gross_int)) gia,
        ROUND(SUM(area_manual_gia)) gia2,
        COUNT(bl_fl) total_floors,
        COUNT_IF(floor_status IN ('ACTIVE', 'READY')) active_floors
    FROM TABLE1 bfd
    WHERE
        bfd.ds = (
            SELECT
                MAX(ds)
            FROM "TABLE2$partitions"
        )
        AND full_date = '2022-12-30'
        AND is_parking = FALSE
        AND data_center_flag LIKE 'N'
        AND current_building_status IN ('ACTIVE', 'READY')
        AND floor_status IN ('ACTIVE', 'READY')
        -- AND regn_id LIKE 'BAYAREA'
    GROUP BY
        1, 2, 3, 4, 5, 6
),
fur AS (
    SELECT DISTINCT
        regn_id,
        COALESCE(IF(bl_id LIKE 'N/A', address1, bl_id), SUBSTR(ls_id, 1, 7)) bl_ls_id,
        office_status,
        SUM(area_rentable) rsf
    FROM TABLE3
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE3$partitions"
        )
        -- AND regn_id LIKE 'HQ'
        AND office_status NOT LIKE 'Expired%'
        AND lower(office_status) NOT LIKE '%pending%'
        AND office_status NOT IN ('Non-Binding Agreement')
        AND pri_bus_fun NOT IN ('Datacenters', 'Parking')
        AND lease_type IN ('Office', 'Serviced Office', 'Headquarters')
    GROUP BY
        1, 2, 3
    ORDER BY
        1 ASC
),
bldgs AS (
    SELECT
        regn_id,
        site_id,
        campus,
        bl_id,
        current_building_status,
        address1,
        CASE
            WHEN rsf >= rsf2 THEN rsf
            ELSE COALESCE(rsf2, rsf)
        END rsf,
        active_floors,
        total_floors
        -- CASE
        --     WHEN usf >= usf2 THEN usf
        --     ELSE COALESCE(usf2, usf)
        -- END usf,
        -- CASE
        --     WHEN gia >= gia2 THEN gia
        --     ELSE COALESCE(gia2, gia)
        -- END gia
    FROM bl_fl
),
rooms AS (
    SELECT
        bl_id,
        CAST(SUM(area) AS INT) area_used,
        COUNT_IF(rm_cat NOT LIKE 'PERS') total_rooms
    FROM TABLE4
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE4$partitions"
        )
        AND (
            (
                LOWER(rm_cat) IN (
                    'support',
                    'amenity',
                    'meeting',
                    'shared',
                    'storage',
                    'lab',
                    'pers'
                )
            )
            OR (LOWER(rm_std) IN ('support', 'collab'))
            OR (LOWER(rm_type) IN ('desk', 'huddle', 'breakout', 'cafe-dine'))
            AND (
                rm_cat NOT LIKE 'VERT%'
                OR rm_cat NOT LIKE 'EXT%'
            )
        )
        AND rm_id IS NOT NULL
    GROUP BY
        1

),
base AS (
    SELECT
        COALESCE(b.regn_id, f.regn_id) regn_id,
        b.site_id,
        b.campus,
        CASE
            WHEN b.bl_id IS NULL AND LENGTH(f.bl_ls_id) = 7 THEN f.bl_ls_id
            WHEN b.bl_id IS NOT NULL THEN b.bl_id
            ELSE NULL
        END bl_id,
        f.bl_ls_id,
        b.current_building_status,
        f.office_status,
        CASE
            WHEN b.bl_id IS NULL THEN f.rsf
            WHEN b.rsf >= r.area_used THEN CASE
                WHEN f.rsf >= b.rsf THEN f.rsf
                ELSE b.rsf
            END
            ELSE r.area_used
        END rsf,
        b.active_floors,
        b.total_floors,
        r.total_rooms,
        CASE
            WHEN b.bl_id IS NULL THEN 'system1'
            WHEN b.rsf >= r.area_used THEN CASE
                WHEN f.rsf >= b.rsf THEN 'system1'
                ELSE 'system2a'
            END
            ELSE 'system2b'
        END rsf_source
    FROM bldgs b
    LEFT JOIN rooms r
        ON b.bl_id = r.bl_id
    FULL JOIN fur f
        ON b.bl_id = f.bl_ls_id
        OR b.address1 = f.bl_ls_id

)
SELECT
    *
FROM base
WHERE
    bl_id IS NOT NULL
ORDER BY
    1, 2, 3, 4
