WITH bl_fl_occ AS (
    SELECT
        ds,
        full_date,
        regn_id,
        site_id,
        city,
        campus,
        ctry_id,
        building_use,
        building_name,
        current_building_status,
        bl_fl,
        floor_status,
        -- is_parking,
        SUM(total_desks) capacity,
        SUM(total_seated) occupancy,
        CASE
            WHEN LAG(current_building_status) OVER (
                PARTITION BY
                    bl_fl
                ORDER BY
                    DATE(full_date) ASC
            ) != current_building_status THEN DATE(full_date)
            ELSE NULL
        END bldg_closed
        -- SUM(occupancy) def_occ
    FROM TABLE1
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE1$partitions"
        )
        AND is_last_day_of_month_or_latest_date = TRUE
        AND YEAR(DATE(full_date)) > 2021
        AND floor_status NOT LIKE 'NEW'
        AND is_parking = FALSE
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12
),
prior_occ AS (
    SELECT
        *,
        LAG(occupancy) OVER (
            PARTITION BY
                bl_fl
            ORDER BY
                full_date
        ) occupancy_lm,
        occupancy - LAG(occupancy) OVER (
            PARTITION BY
                bl_fl
            ORDER BY
                full_date
        ) AS chng_fm_lm
    FROM bl_fl_occ
),
chng_flags AS (
    SELECT
        *,
        CASE
            WHEN (
                chng_fm_lm = 0 OR chng_fm_lm IS NULL
            ) THEN 'No change'
            ELSE 'Change'
        END chng_flag
    FROM prior_occ
)
SELECT
    *
FROM chng_flags
WHERE
    chng_flag LIKE 'Change'
ORDER BY
    bl_fl,
    full_date ASC
