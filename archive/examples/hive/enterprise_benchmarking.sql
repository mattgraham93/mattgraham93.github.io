WITH q_ds AS (
    SELECT
        '2022-12-30' main_ds,
        DATE_ADD('day', -2, DATE(MAX(ds))) alt_ds
    FROM "TABLE1$partitions"
),
costar AS (
    SELECT DISTINCT
        region,
        f.bl_id,
        f.address1,
        f.address2,
        f.name,
        -- CASE
        --     WHEN f.address2 IS NULL THEN f.address1
        --     ELSE CONCAT(f.address1, ', ', f.address2)
        -- END address,
        -- clientleaseid,
        CASE
            WHEN MIN(leaserecoverytype) LIKE 'Full Service Gross' THEN 'GROSS'
            WHEN MIN(leaserecoverytype) LIKE 'Modified Gross' THEN 'MG'
            ELSE MIN(leaserecoverytype)
        END lease_recovery,
        -- officetype,
        MIN(leasestatus) lease_status,
        MIN(f.lease_type) lease_type,
        SUM(CAST(rentableareasfequivalent AS INT)) OVER (
            PARTITION BY
                f.bl_id,
                f.address1,
                f.address2
        ) rsf,
        -- f.ls_id,
        -- archibusbuildingid
        SUM(CAST(f.area_negotiated AS INT)) OVER (
            PARTITION BY
                f.bl_id,
                f.address1,
                f.address2
        ) usf
    FROM TABLE1 rd
    LEFT JOIN (
        SELECT
            *
        FROM TABLE2
        WHERE
            ds = '2022-12-30'
    ) f
        ON rd.clientleaseid = f.ls_id
    WHERE
        rd.ds = (
            SELECT
                MAX(ds)
            FROM "TABLE2$partitions"
        )
        -- AND leasestatus NOT LIKE 'Expired'
        AND region LIKE 'HQ'
        AND bl_id IS NOT NULL
    GROUP BY
        1, 2, 3, 4, 5, rentableareasfequivalent,
        area_negotiated
),
occ AS (
    SELECT
        regn_id,
        site_id,
        campus,
        bl_id,
        h.address1,
        h.building_name,
        AVG(sharing_ratio) sharing_ratio,
        ROUND(SUM(area_gross_int)) b_gsf,
        ROUND(SUM(area_rentable)) b_rsf,
        ROUND(SUM(area_usable)) b_usf,
        SUM(total_desks) b_capacity,
        SUM(occupied_desks) assigned_desks,
        SUM(total_seated) assigned_hc,
        SUM(hotelable_desks) AS dropin_desks,
        SUM(reservable_desks) AS reservable_desks,
        SUM(assigned_seating) AS assigned_seated_hc,
        SUM(assigned_neighborhood) AS shared_seated_hc,
        ROUND(
            SUM(occupied_desks) + (
                (SUM(hotelable_desks) + SUM(hotelable_desks) + SUM(reservable_desks))
                    * AVG(COALESCE(sharing_ratio, 1))
            )
        ) tot_shared_capacity,
        ROUND(SUM(total_desks)) design_capacity
    FROM TABLE3 h
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE3$partitions"
        )
        AND full_date = '2022-12-30'
        -- AND floor_status NOT IN ('CLOSED', 'PENDING')
        AND regn_id LIKE 'BAYAREA'
    GROUP BY
        1, 2, 3, 4, 5, 6
),
emp AS (
    SELECT
        regn_id,
        bl_id,
        hc_type,
        APPROX_DISTINCT(em_id) tot_emps
    FROM TABLE4
    WHERE
        ds = (
            SELECT
                MAX(ds)
            FROM "TABLE4$partitions"
        )
        AND regn_id LIKE 'BAYAREA'
        AND hc_type LIKE 'REMOTE'
    GROUP BY
        1, 2, 3
),
room_cap AS (
    SELECT
        r.bl_id,
        r.fl_id,
        ELEMENT_AT(room, 'rm_id') rm_id,
        CAST(ELEMENT_AT(room, 'capacity') AS DOUBLE) rm_cap
        -- desk_capacity,
        -- total_capacity
    FROM TABLE5 r
    CROSS JOIN UNNEST(room_list_detailed) AS t(room)
    WHERE
        ds = '2022-12-30'
    ORDER BY
        1, 2, 3
),
room_space AS (
    SELECT
        r.bl_id,
        r.rm_id,
        rm_cat,
        rm_std,
        rm_type,
        CAST(
            SUM(
                IF(
                    (rm_cat IN ('AMENITY', 'LAB', 'STORAGE')) OR (
                        rm_type LIKE 'CAFE%' OR rm_type LIKE 'FITNESS'
                    ),
                    area,
                    0
                )
            ) AS int
        ) amenity_sf,
        CAST(SUM(IF(rm_cat LIKE 'PERS', area, 0)) AS int) indv_sf,
        CAST(SUM(IF(rm_std LIKE 'COLLAB', area, 0)) AS int) collab_sf,
        CAST(
            SUM(
                IF(
                    (rm_cat LIKE 'SUPPORT') OR (rm_std LIKE 'SUPPORT'),
                    area,
                    0
                )
            ) AS int
        ) support_sf,
        CAST(SUM(area) AS INT) circ_sf,
        CAST(SUM(IF(NOT(rm_cat LIKE 'DESK'), area)) AS INT) rm_sf,
        APPROX_DISTINCT(
            IF(
                rm_cat NOT LIKE 'PERS' AND rm_std NOT LIKE 'CIRC',
                r.rm_id
            )
        ) b_enclosed_rooms,
        APPROX_DISTINCT(IF(rm_cat NOT LIKE 'PERS', r.rm_id)) total_rooms,
        CAST(
            SUM(
                IF (
                    rm_cat NOT LIKE 'PERS' AND rm_std NOT LIKE 'CIRC',
                    rc.rm_cap
                )
            ) AS INT
        ) enclosed_capacity
    FROM TABLE6 r
    LEFT JOIN room_cap rc
        ON r.bl_id = rc.bl_id
        AND r.fl_id = rc.fl_id
        AND r.rm_id = rc.rm_id
    WHERE
        ds = '2022-12-30'
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
        AND r.rm_id IS NOT NULL
    GROUP BY
        1, 2, 3, 4, 5
),
final AS (
    SELECT
        COALESCE(b.regn_id, c.region) regn_id,
        b.site_id,
        b.campus,
        COALESCE(b.bl_id, c.bl_id) bl_id,
        c.address1,
        COALESCE(b.building_name, c.name) name,
        c.lease_recovery,
        c.lease_status,
        c.lease_type,
        COALESCE(b.b_gsf, c.rsf) b_gsf,
        COALESCE(b.b_rsf, c.rsf) b_rsf,
        COALESCE(b.b_usf, c.usf) b_usf,
        b.b_capacity,
        b.assigned_desks,
        b.assigned_hc,
        b.dropin_desks,
        b.reservable_desks,
        b.assigned_seated_hc,
        b.shared_seated_hc,
        b.tot_shared_capacity,
        b.sharing_ratio,
        SUM(emp.tot_emps) tot_rem_emps,
        SUM(rm_sf) rm_sf,
        SUM(circ_sf) circ_sf,
        SUM(amenity_sf) amenity_sf,
        SUM(collab_sf) collab_sf,
        SUM(indv_sf) indv_sf,
        SUM(support_sf) support_sf,
        SUM(b_enclosed_rooms) b_closed_rooms,
        SUM(total_rooms) b_total_rooms,
        0 b_total_offices,
        SUM(enclosed_capacity) b_enclosed_capacity
    FROM occ b
    FULL JOIN costar c
        ON b.bl_id = c.bl_id
        OR b.address1 = c.address1
    LEFT JOIN room_space rs
        ON b.bl_id = rs.bl_id
    LEFT JOIN emp
        ON b.bl_id = emp.bl_id
        -- WHERE
        --     b.bl_id IS NULL
    GROUP BY
        1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21
)
SELECT
    *,
    (b_total_offices + assigned_desks + dropin_desks + reservable_desks) design_capacity,
    ROUND(((assigned_desks) + (shared_seated_hc * sharing_ratio))) sharing_cap_s_wkstns
FROM final
