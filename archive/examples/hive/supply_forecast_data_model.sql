WITH const_proj AS (
    SELECT
        region regn_id,
        site,
        project project_name,
        IF(bl_id IS NULL, site, bl_id) bl_id,
        -- CONCAT(bl_id, ' - N/A') bl_fl,
        project_status,
        COALESCE(seating_capacity, 0) capacity,
        COALESCE(rentable_sqft, gross_internal_area_sqft, 0) rentable_sqft,
        1 sharing_ratio,
        NULL bldg_occ,
        NULL bldg_hc,
        DATE_TRUNC('month', CAST(fdob_date AS DATE)) fdob_date,
        country,
        city,
        'N/A' office_type,
        'N/A' primary_business,
        action_type,
        alias,
        'Construction' bldg_source
    FROM TABLE1
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE1$partitions"
        )
        AND project_status NOT IN ('Completed', 'Cancelled', 'On Hold')
        AND fdob_date IS NOT NULL
        AND site IS NOT NULL
        AND fdob_date > CURRENT_DATE
        -- add fdob filter to exclude past fdobs
),
pipeline_proj AS (
    SELECT
        -- ds,
        region regn_id,
        site,
        project_name,
        IF(project_id IS NULL, 'N/A', CAST(project_id AS VARCHAR)) bl_id,
        -- CONCAT(CAST(project_id AS VARCHAR), ' - N/A') bl_fl,
        project_status,
        COALESCE(capacity, 0),
        COALESCE(rentable_sqft, 0),
        1 sharing_ratio,
        NULL bldg_occ,
        NULL bldg_hc,
        DATE_TRUNC('month', CAST(fdob_date AS DATE)) fdob_date,
        country,
        city,
        office_type,
        primary_business,
        action_type,
        alias,
        'Pipeline' bldg_source
    FROM TABLE2
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE2$partitions"
        )
        AND show_in_portfolio_tool = 1
        AND project_status LIKE 'Active'
        AND fdob_date > CURRENT_DATE
        -- add fdob filter to exclude past fdobs
),
future_projects AS (
    SELECT
        *
    FROM const_proj

    UNION ALL

    SELECT
        *
    FROM pipeline_proj
),
hyperion_fcst AS (
    SELECT DISTINCT
        fcst_date
    FROM TABLE3
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE3$partitions"
        )
        AND hyperion_snapshot_name LIKE 'Budget 2023%'
        AND YEAR(fcst_date) >= 2022
        AND MONTH(fcst_date) IN (3, 6, 9, 12)
),
fcst_min_max AS (
    SELECT
        MIN(fcst_date) min_fd,
        MAX(fcst_date) max_fd
    FROM hyperion_fcst
),
bl_fls AS (
    SELECT DISTINCT
        -- ds,
        'Archibus' bldg_source,
        regn_id,
        site_id site,
        afo.bl_id,
        building_name,
        building_use,
        bl_fl,
        CAST(full_date AS DATE) full_date,
        current_building_status,
        -- floor_status,
        SUM(occupancy) bldg_occ, -- sum since across multiple floors
        SUM(total_desks) bldg_cap, -- sum since across multiple floors
        SUM(total_seated) bldg_hc, -- allocated to desk/planning group, loose "headcount"; likely to be higher than total_desks. sum since across multiple floors
        DATE_TRUNC(
            'month',
            CAST(COALESCE(MIN(start_date), MIN(ready_date)) AS DATE)
        ) floor_date,
        DATE_TRUNC(
            'month',
            CAST(
                COALESCE(CAST(MAX(floor_close_date) AS DATE), MAX(date_end)) AS DATE
            )
        ) close_date,
        COALESCE(SUM(area_rentable), SUM(area_manual_gea)) rsf, -- avg for static across multiple floors
        COALESCE(SUM(area_gross_int), SUM(area_manual_gia)) gfa -- avg for static
    FROM TABLE4 afo
    FULL JOIN (
        SELECT DISTINCT
            bl_id,
            MAX(date_end) date_end
        FROM TABLE5
        WHERE
            is_active
            AND is_valid_lease
            AND ds = (
                SELECT
                    MAX(ds)
                FROM "TABLE5$partitions"
            )
        GROUP BY
            1
    ) cstar
        ON cstar.bl_id = afo.bl_id
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE4$partitions"
        )
        AND YEAR(CAST(full_date AS DATE)) >= 2022
        AND MONTH(CAST(full_date AS DATE)) IN (3, 6, 9, 12)
        AND CAST(full_date AS DATE) = DATE_TRUNC('month', CAST(full_date AS DATE))
        AND floor_status IN ('ACTIVE', 'READY')
        AND data_center_flag LIKE 'N'
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9
),
dispo AS (
    -- only get buildings where moveout date exists
    SELECT DISTINCT
        SUBSTR(bl_id, 1, 7) bl_id,
        CASE
            WHEN move_out_date IN ('N/A', '', 'Unoccupied') THEN NULL
            ELSE DATE_TRUNC(
                'month',
                MAX(TRY(CAST(DATE_PARSE(move_out_date, '%m/%d/%Y') AS DATE)))
            )
        END move_out_date,
        CASE
            WHEN move_out_date IN ('N/A', '') THEN NULL
            WHEN move_out_date LIKE 'Unoccupied' THEN 'Unoccupied'
            ELSE 'Occupied'
        END occupancy_flag,
        NULLIF(action_conf, '') action_conf,
        NULLIF(curr_action, '') curr_action,
        NULLIF(status, '') status,
        SUM(sf_red) sf_red,
        SUM(seats_red) seats_red
        -- COUNT(bl_id) leases_red
    FROM TABLE6
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE6$partitions"
        )
        -- AND move_out_date NOT IN ('N/A', '', 'Unoccupied')
        -- AND status LIKE 'Approved'
    GROUP BY
        1, move_out_date,
        4, 5, 6
),
building_occ AS (
    SELECT
        bldg_source,
        regn_id,
        site,
        bl_id,
        building_name,
        building_use,
        full_date,
        current_building_status,
        SUM(bldg_occ) bldg_occ,
        SUM(bldg_cap) bldg_cap,
        SUM(bldg_hc) bldg_hc,
        SUM(bldg_hc) / SUM(bldg_cap) sharing_ratio,
        SUM(rsf) rsf,
        MIN(floor_date) bldg_fdob,
        MAX(close_date) bldg_end
    FROM bl_fls
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8
),
bldg_occ_latest AS (
    SELECT
        *
    FROM building_occ
    WHERE
        full_date = (
            SELECT
                MAX(full_date)
            FROM building_occ
        )
),
-- active / leased floors/buildings
bldg_fcst_agg AS (
    SELECT DISTINCT
        bo.bl_id,
        hf.fcst_date
    FROM building_occ bo
    CROSS JOIN (
        SELECT DISTINCT
            fcst_date
        FROM hyperion_fcst
    ) hf
),
active_bldg_historicals AS (
    SELECT DISTINCT
        bfa.bl_id,
        bfa.fcst_date,
        bo.regn_id,
        bo.site,
        bo.building_name alias,
        bo.building_use,
        bo.bldg_fdob,
        bo.bldg_end,
        bldg_cap,
        bldg_occ,
        bldg_hc,
        sharing_ratio,
        rsf,
        bo.bldg_source
        -- max_full_date
    FROM bldg_fcst_agg bfa
    LEFT OUTER JOIN building_occ bo
        ON bfa.bl_id = bo.bl_id
    WHERE
        bfa.fcst_date = bo.full_date
),
empty_active_bldg_fcst AS (
    SELECT
        *
    FROM bldg_fcst_agg bfa
    WHERE
        NOT EXISTS (
            SELECT
                bl_id,
                fcst_date
            FROM active_bldg_historicals abh
            WHERE
                abh.bl_id = bfa.bl_id
                AND abh.fcst_date = bfa.fcst_date
        )
),
active_bldg_fcst AS (
    SELECT
        eabf.bl_id,
        eabf.fcst_date,
        bol.regn_id,
        bol.site,
        bol.building_name alias,
        bol.building_use,
        bol.bldg_fdob,
        bol.bldg_end,
        IF(
            (
                eabf.fcst_date BETWEEN bol.bldg_fdob AND bol.bldg_end
            ) OR (
                bol.bldg_fdob IS NOT NULL AND bol.bldg_end IS NULL
            ),
            bol.bldg_cap,
            0
        ) bldg_cap,
        IF(
            (
                eabf.fcst_date BETWEEN bol.bldg_fdob AND bol.bldg_end
            ) OR (
                bol.bldg_fdob IS NOT NULL AND bol.bldg_end IS NULL
            ),
            bol.bldg_occ, -- set to null since we do not know future occupancy in a building
            0
        ) bldg_occ,
        IF(
            (
                eabf.fcst_date BETWEEN bol.bldg_fdob AND bol.bldg_end
            ) OR (
                bol.bldg_fdob IS NOT NULL AND bol.bldg_end IS NULL
            ),
            bol.bldg_hc,
            0
        ) bldg_hc,
        IF(
            (
                eabf.fcst_date BETWEEN bol.bldg_fdob AND bol.bldg_end
            ) OR (
                bol.bldg_fdob IS NOT NULL AND bol.bldg_end IS NULL
            ),
            bol.sharing_ratio,
            0
        ) sharing_ratio,
        IF(
            (
                eabf.fcst_date BETWEEN bol.bldg_fdob AND bol.bldg_end
            ) OR (
                bol.bldg_fdob IS NOT NULL AND bol.bldg_end IS NULL
            ),
            bol.rsf,
            0
        ) rsf,
        bol.bldg_source
    FROM empty_active_bldg_fcst eabf
    LEFT JOIN bldg_occ_latest bol
        ON eabf.bl_id = bol.bl_id
),
full_active_model AS (
    SELECT
        *
    FROM active_bldg_historicals abh

    UNION ALL

    SELECT
        *
    FROM active_bldg_fcst
),
-- planned building mapping
future_bldg_fcst_agg AS (
    SELECT DISTINCT
        fcst_date,
        fp.regn_id,
        fp.site,
        fp.bl_id,
        -- fp.bl_fl,
        fp.alias,
        IF(fcst_date < fp.fdob_date, NULL, fp.fdob_date) bldg_fdob,
        IF(fcst_date < fp.fdob_date, NULL, fmm.max_fd) bldg_end
    FROM hyperion_fcst hf
    CROSS JOIN future_projects fp
    CROSS JOIN fcst_min_max fmm
),
future_bldg_fcst AS (
    SELECT DISTINCT
        fbfa.fcst_date,
        fbfa.regn_id,
        fbfa.site,
        fbfa.bl_id,
        -- fbfa.bl_fl,
        fbfa.alias,
        fbfa.bldg_fdob,
        fbfa.bldg_end,
        IF(fbfa.bldg_fdob IS NULL, 0, fp.capacity) bldg_cap,
        bldg_occ,
        bldg_hc,
        sharing_ratio,
        IF(fbfa.bldg_fdob IS NULL, 0, fp.rentable_sqft) rsf,
        fp.bldg_source
    FROM future_bldg_fcst_agg fbfa
    LEFT JOIN future_projects fp
        ON fbfa.alias = fp.alias
),
total_supply AS (
    SELECT
        bl_id,
        fcst_date,
        regn_id,
        site,
        alias,
        bldg_fdob,
        bldg_end,
        bldg_cap,
        bldg_occ,
        bldg_hc,
        sharing_ratio,
        rsf,
        bldg_source
    FROM future_bldg_fcst
    WHERE
        bl_id NOT IN (
            SELECT
                bl_id
            FROM building_occ
        )

    UNION ALL

    SELECT
        bl_id,
        fcst_date,
        regn_id,
        site,
        alias,
        bldg_fdob,
        bldg_end,
        bldg_cap,
        bldg_occ,
        bldg_hc,
        sharing_ratio,
        rsf,
        bldg_source
    FROM full_active_model fam
),
full_dispo AS (
    SELECT
        ts.bl_id,
        DATE(fcst_date) fcst_date,
        regn_id,
        site,
        alias,
        bldg_fdob,
        bldg_end,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN CASE
                WHEN bldg_cap - d.seats_red < 0 THEN NULL
                ELSE bldg_cap - d.seats_red
            END
            ELSE bldg_cap
        END bldg_cap,
        bldg_occ,
        bldg_hc,
        sharing_ratio,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN CASE
                WHEN rsf - d.sf_red < 0 THEN NULL
                ELSE rsf - d.sf_red
            END
            ELSE rsf
        END rsf,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN 'Dispositions'
            ELSE bldg_source
        END bldg_source,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date BETWEEN LAG(fcst_date) OVER (
                PARTITION BY
                    ts.bl_id
                ORDER BY
                    fcst_date
            ) AND fcst_date THEN TRUE
            ELSE FALSE
        END disposed_this_qtr,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN COALESCE(
                d.action_conf,
                NULL
            )
            ELSE NULL
        END action_conf,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN COALESCE(
                d.status,
                'Undisposed'
            )
            ELSE 'Undisposed'
        END dispo_status,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date
                THEN COALESCE(d.occupancy_flag, NULL)
            ELSE NULL
        END occupancy_flag,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN COALESCE(
                d.curr_action,
                NULL
            )
            ELSE NULL
        END curr_action,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN COALESCE(
                d.sf_red,
                0
            )
            ELSE 0
        END sf_red,
        CASE
            WHEN ts.bl_id = d.bl_id AND d.move_out_date <= fcst_date THEN COALESCE(
                d.seats_red,
                0
            )
            ELSE 0
        END seats_red
    FROM total_supply ts
    LEFT JOIN dispo d
        ON ts.bl_id = d.bl_id
)
SELECT
    *,
    LAG(bldg_cap) OVER (
        PARTITION BY
            bl_id
        ORDER BY
            fcst_date
    ) last_cap
    --     regn_id,
    --     fcst_date,
    --     SUM(bldg_hc)
FROM full_dispo
    -- WHERE
    --     regn_id LIKE 'NAM'
    -- GROUP BY
    --     1, 2
ORDER BY
    1, 2 ASC
