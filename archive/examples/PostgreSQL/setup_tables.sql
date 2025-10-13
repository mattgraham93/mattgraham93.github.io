CREATE TABLE iot.sensor_msmt (
	sensor_id int not null,
	msmt_date date not null,
	temperature int,
	humidity int
) PARTITION BY RANGE (msmt_date);

CREATE TABLE io_sensor_msmt_y2021m01 PARTITION OF iot.sensor_msmt
	FOR VALUES FROM ('2021-01-01') TO ('2021-01-31');
	
CREATE TABLE io_sensor_msmt_y2021m02 PARTITION OF iot.sensor_msmt
	FOR VALUES FROM ('2021-02-01') TO ('2021-02-28');