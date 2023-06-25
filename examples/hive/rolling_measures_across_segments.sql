WITH badging AS (
    SELECT
        DATE_TRUNC('quarter', DATE(full_date)) month_start,
        site_id,
        building,
        data_center_flag,
        APPROX_PERCENTILE(
            unique_badge_count - group_segment['NONSEATED'] - group_segment['UNASSIGNED'],
            0.25
        ) p25_badge,
        APPROX_PERCENTILE(
            unique_badge_count - group_segment['NONSEATED'] - group_segment['UNASSIGNED'],
            0.5
        ) p50_badge,
        APPROX_PERCENTILE(
            unique_badge_count - group_segment['NONSEATED'] - group_segment['UNASSIGNED'],
            0.75
        ) p75_badge,
        APPROX_PERCENTILE(
            unique_badge_count - group_segment['NONSEATED'] - group_segment['UNASSIGNED'],
            0.9
        ) p90_badge,
        AVG(
            unique_badge_count - group_segment['NONSEATED'] - group_segment['UNASSIGNED']
        ) avg_badge
        -- ADD P25/50/75, avg
    FROM TABLE1
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE1$partitions"
            WHERE
                agg_level
                    = 'building.country_name.ctry_id.data_center_flag.emp_building.emp_floor.full_date.is_work_day.pg_alloc_area_id.plan_group_id.plan_group_site.region.site_id'
        )
        AND agg_level
            = 'building.country_name.ctry_id.data_center_flag.emp_building.emp_floor.full_date.is_work_day.pg_alloc_area_id.plan_group_id.plan_group_site.region.site_id'
        AND is_work_day = 1
        AND YEAR(DATE(full_date)) = 2022
        AND region LIKE 'BAYAREA'
    GROUP BY
        1, 2, 3, 4
),
totals AS (
    SELECT
        DATE_ADD('month', 2, month_start) month_start,
        site_id,
        building,
        data_center_flag,
        p25_badge,
        p50_badge,
        p75_badge,
        p90_badge,
        ROUND(avg_badge) avg_badge
    FROM badging
)
SELECT
    building,
    data_center_flag,
    MAX(p90_badge) p90_badge,
    MAX(avg_badge) avg_badge
FROM totals
GROUP BY
    1, 2
ORDER BY
    2, 1 ASC
