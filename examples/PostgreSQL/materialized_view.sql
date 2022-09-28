CREATE MATERIALIZED VIEW landon.mv_locations_expenses as (
SELECT
	l.hotel_id, l.city, l.state_province, l.country,
	e.year, e.annual_payroll, e.health_insurance, e.supplies
FROM
	landon.locations l
left join
	landon.expenses e
on (l.hotel_id = e.hotel_id)
);

select * from landon.mv_locations_expenses;

refresh MATERIALIZED view landon.mv_locations_expenses;