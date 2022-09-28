create table landon.locations(
	hotel_id int not null,
	city varchar,
	state_province varchar,
	country varchar
);

create table landon.expenses(
	hotel_id int not null,
	year date,
	annual_payroll int,
	health_insurance boolean,
	supplies varchar
);