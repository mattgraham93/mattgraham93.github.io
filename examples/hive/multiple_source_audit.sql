/*
    iterated from sustainability pull
*/

WITH bldgs AS (
    SELECT
        building,
        regn_id bldg_regn,
        site_id bldg_site,
        name fb_name,
        building_use,
        address1 bldg_address,
        city bldg_city,
        zip_code bldg_zip,
        state_id bldg_state,
        ctry_id bldg_ctry,
        date_start bldg_start,
        date_end bldg_end,
        building_status bldg_status
    FROM TABLE1
    WHERE
        ds = '<LATEST_DS:TABLE1>'
        AND (
            building IS NOT NULL
            OR building NOT IN ('N/A', 'N/a')
        )
),
lease AS (
    SELECT DISTINCT
        ds,
        bl_id,
        ls_id,
        date_start lease_start,
        date_end lease_end,
        lease_type,
        area_rentable rsf,
        area_negotiated gsf,
        pri_bus_fun,
        name lease_name,
        office_status lease_status,
        regn_id lease_regn,
        is_active,
        CONCAT(address1, address2) lease_address,
        city_id lease_city,
        state_id lease_state,
        ctry_id lease_ctry,
        zip lease_zip
    FROM TABLE2
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE2$partitions"
        )
        AND is_valid_lease = TRUE
        AND pri_bus_fun NOT LIKE 'Parking'
        -- AND is_active = TRUE -- must be excluded for owned buildings
),

-- Join and create lease status flags
bldgs_lease_join AS (
    SELECT
        *,
        CASE
            -- capturing whether a building in CoStar exists in Archibus
            WHEN building IS NULL THEN CASE
                WHEN is_active = TRUE AND lease_status NOT LIKE 'Owned'
                    THEN 'Active lease w/o building'
                WHEN lease_status LIKE 'Owned' THEN 'Owned w/o building'
                WHEN is_active = FALSE THEN 'Inactive lease w/o building'
            END
            -- if there is not a match, the building does not exist in Archibus
            WHEN bl_id IS NULL THEN 'Building not in archibus'
            -- capturing matched buildings between CoStar and Archibus
            WHEN is_active = TRUE AND lease_status NOT LIKE 'Owned'
                THEN 'Active lease w/ building'
            WHEN lease_status LIKE 'Owned' THEN 'Owned w/ building'
            WHEN is_active = FALSE THEN 'Inactive lease w/ building'
            -- an edge case has yet to be defined
            ELSE 'Missing flag'
        END lease_flag
    FROM bldgs
        -- we want all leases and buildings
    FULL OUTER JOIN lease
        ON bldgs.building = lease.bl_id
),
bldgs_lease_clean AS (
    SELECT
        ls_id,
        COALESCE(building, bl_id) building,
        COALESCE(fb_name, lease_name) bldg_name,
        COALESCE(bldg_regn, lease_regn) region,
        COALESCE(bldg_ctry, lease_ctry) country,
        COALESCE(bldg_site, 'N/A') site,
        COALESCE(bldg_address, lease_address) address,
        COALESCE(bldg_zip, lease_zip) zip_code,
        COALESCE(bldg_start, lease_start) fdob,
        COALESCE(bldg_end, lease_end) close_date,
        ds,
        rsf,
        pri_bus_fun,
        building_use,
        lease_flag,
        bldg_status,
        lease_status
    FROM bldgs_lease_join
    WHERE
        lease_flag NOT LIKE 'Inactive%' -- added to keep owned buildings and now inactive leases for only leased buildings
)
select * from bldgs_lease_clean
