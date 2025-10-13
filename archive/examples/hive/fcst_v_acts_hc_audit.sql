WITH act_emps AS (
    SELECT
        CASE
            WHEN region_name LIKE 'Canada' THEN 'US'
            ELSE region_name
        END regn_id,
        -- NULL site,
        -- NULL fcst_date,
        APPROX_DISTINCT(employee_id) total_emps,
        'actuals' source_flag
    FROM TABLE1:NS1
    WHERE
        ds = '2023-01-10'
        AND is_active = TRUE
    GROUP BY
        CASE
            WHEN region_name LIKE 'Canada' THEN 'US'
            ELSE region_name
        END
),
hyperion_fcst AS (
    SELECT
        CASE
            WHEN region_code IN ('NAM', 'BAYAREA') THEN 'US'
            WHEN region_code LIKE 'LAD' THEN 'LatAm'
            ELSE region_code
        END regn_id,
        -- site_code site,
        fcst_date,
        SUM(monthly_fcst_hc) total_emps, -- quarterly returns same number
        'hyperion' source_flag
    FROM TABLE2:NS2
    WHERE
        ds = CURRENT_DATE
        -- AND upload_type LIKE 'LRP'
        AND hyperion_snapshot_name like 'Budget 2023%'
        AND fcst_month IN (3, 6, 9, 12)
    GROUP BY
        -- ds,
        fcst_date,
        -- site_code,
        CASE
            WHEN region_code IN ('NAM', 'BAYAREA') THEN 'US'
            WHEN region_code LIKE 'LAD' THEN 'LatAm'
            ELSE region_code
        END
        -- monthly_fcst_hc
),
to_pvt AS (
    SELECT
        regn_id,
        hf.fcst_date,
        total_emps,
        source_flag
    FROM act_emps
    CROSS JOIN (
        SELECT DISTINCT
            fcst_date
        FROM hyperion_fcst
    ) hf

    UNION ALL

    SELECT
        regn_id,
        fcst_date,
        total_emps,
        source_flag
    FROM hyperion_fcst
),
people_pvt AS (
    SELECT
        regn_id,
        -- site,
        fcst_date,
        kv['hyperion'] fcst_hc,
        kv['actuals'] act_hc
    FROM (
        SELECT
            regn_id,
            -- site_code,
            fcst_date,
            MAP_AGG(source_flag, total_emps) kv
        FROM to_pvt
        GROUP BY
            regn_id,
            fcst_date
    ) p
)
SELECT
    *
FROM people_pvt
ORDER BY
    1, 2 ASC
