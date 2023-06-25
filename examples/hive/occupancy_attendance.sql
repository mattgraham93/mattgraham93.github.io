WITH b AS (
    SELECT
        ds,
        building,
        campus,
        COALESCE(building_group, building) AS building_group,
        site_id,
        regn_id
    FROM TABLE1:NS1
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE1:NS1$partitions"
        )
),
arch AS (
    --Output the historical archibus data used for metrics
    SELECT
        full_date,
        is_weekday,
        regn_id,
        site_id,
        data_center_flag,
        campus,
        bl_id,
        plan_group_id,
        plan_group_site,
        SUM(total_desks) AS total_desks,
        SUM(occupied_desks) AS assigned_desks,
        SUM(reservable_desks) AS reservable_desks,
        SUM(hotelable_desks) AS dropin_desks,
        SUM(total_seated) AS total_seated,
        SUM(assigned_seating) AS assigned_seated_hc,
        SUM(assigned_neighborhood) AS shared_seated_hc
    FROM TABLE2:NS1
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE2:NS1$partitions"
        )
        AND floor_status = 'ACTIVE'
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9

),
building_attendance AS (
    --Output provides 1 row per building and planning_group
    --exclude unassigned and nonseated
    SELECT
        full_date,
        is_work_day,
        region,
        site_id,
        data_center_flag,
        building,
        plan_group_id,
        plan_group_site,
        -- SUM(COALESCE(unique_badge_count,0)) AS unique_badge_count,
        SUM(IF(segment = 'REMOTE', num, 0)) AS remote_count,
        SUM(
            IF(
                emp_building = building AND segment = 'ASSIGNED',
                num,
                0
            )
        ) AS assigned_count,

        SUM(
            IF(
                (
                    emp_building != building AND segment = 'ASSIGNED'
                ) OR segment = 'INTRA-CAMPUS',
                num,
                0
            )
        ) AS intra_campus_count,
        SUM(IF(segment = 'INTRA-SITE', num, 0)) AS intra_site_count,
        SUM(IF(segment = 'TRAVELER', num, 0)) AS traveler_count

    FROM fct_fsc_ccure_unified_badging_cube AS b
    CROSS JOIN UNNEST(group_segment) AS t(segment, num)

    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "fct_fsc_ccure_unified_badging_cube$partitions"
            WHERE
                agg_level
                    = 'building.country_name.ctry_id.data_center_flag.emp_building.emp_floor.full_date.is_work_day.pg_alloc_area_id.plan_group_id.plan_group_site.region.site_id'
        )
        AND agg_level
            = 'building.country_name.ctry_id.data_center_flag.emp_building.emp_floor.full_date.is_work_day.pg_alloc_area_id.plan_group_id.plan_group_site.region.site_id'
        AND segment NOT IN ('NONSEATED', 'OTHER')
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8
)

SELECT
    COALESCE(arch.full_date, ba.full_date) AS full_date,
    COALESCE(arch.is_weekday, ba.is_work_day = 1) AS is_work_day,
    COALESCE(arch.regn_id, ba.region) AS regn_id,
    COALESCE(arch.site_id, ba.site_id) AS site_id,
    COALESCE(arch.bl_id, ba.building) AS building,
    -- COALESCE(arch.plan_group_id, ba.plan_group_id) AS plan_group_id,
    -- COALESCE(arch.plan_group_site, ba.plan_group_site) AS plan_group_site,
    SUM(arch.total_desks) total_desks,
    SUM(arch.total_seated) total_seated,
    SUM(arch.assigned_desks) assigned_desks,
    SUM(arch.reservable_desks) reservable_desks,
    SUM(arch.dropin_desks) dropin_desks,
    SUM(arch.assigned_seated_hc) assigned_seated_hc,
    SUM(arch.shared_seated_hc) shared_seated_hc,
    SUM(ba.remote_count) remote_count,
    COALESCE(SUM(ba.assigned_count), 0) AS seated_attendance,
    SUM(ba.intra_campus_count) intra_campus_count,
    SUM(ba.intra_site_count) intra_site_count,
    -- ba.intra_region_count,
    SUM(ba.traveler_count),
    COALESCE(
        SUM(ba.remote_count) + SUM(ba.intra_campus_count) + SUM(ba.intra_site_count)
            + SUM(ba.traveler_count),
        0
    ) AS traveler_attendance
FROM arch AS arch
FULL OUTER JOIN building_attendance AS ba
    ON arch.full_date = ba.full_date
    AND arch.bl_id = ba.building
    AND arch.plan_group_id = ba.plan_group_id
    AND arch.plan_group_site = ba.plan_group_site
WHERE
    COALESCE(arch.regn_id, ba.region) = 'BAYAREA'
    AND SUBSTR(COALESCE(arch.bl_id, ba.building), 4, 4) NOT LIKE '%P%'
GROUP BY 1, 2, 3, 4, 5
