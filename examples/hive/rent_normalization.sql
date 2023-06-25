WITH deal_approvals AS (
    SELECT
        regn_id,
        ctry_id,
        city_id,
        bl_id,
        ls_id,
        lease_type,
        lease_start_date date_start,
        date_end,
        area_rentable,
        area_negotiated,
        CASE
            WHEN address2 IS NULL THEN address1
            ELSE CONCAT(address1, ' ', address2)
        END address,
        DATE_DIFF('day', lease_start_date, date_end) dur_days,
        DATE_DIFF('month', lease_start_date, date_end) dur_months,
        DATE_DIFF('year', lease_start_date, date_end) dur_years,
        SUM(total_non_rent_expenses) total_non_rent_expenses,
        SUM(total_rent_expenses) total_rent_expenses,
        CASE
            WHEN lease_type NOT IN ('Serviced Office', 'Virtual Office', 'Parking')
                AND area_rentable > 300 THEN SUM(total_non_rent_expenses)
                + SUM(total_rent_expenses)
            ELSE 0
        END total_expenses
    FROM TABLE1
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE1$partitions"
        )
        -- AND is_active
        -- AND is_valid_lease = TRUE
        AND lease_type NOT IN ('Data Center', 'Parking', 'Land', 'Storage')
        AND DATE(date_end) >= CURRENT_DATE
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
)
SELECT
    da.*,
    ROUND(((((total_rent_expenses / dur_days) * 365) / 12) / area_rentable), 2) monthly_rent,
    ROUND(((total_rent_expenses / dur_days) * 365) / area_rentable, 2) annual_rent,
    ROUND(((((total_expenses / dur_days) * 365) / 12) / area_rentable), 2) monthly_cost,
    ROUND(((total_expenses / dur_days) * 365) / area_rentable, 2) annual_cost
FROM deal_approvals da
ORDER BY
    1, 4, 5 ASC
