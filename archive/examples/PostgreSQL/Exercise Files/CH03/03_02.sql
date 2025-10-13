
DROP TABLE IF EXISTS iot.sensor_msmt;
CREATE TABLE iot.sensor_msmt (
   sensor_id        int not null,
   msmt_date        date not null,
   temperature      int,
   humidity         int
) PARTITION BY RANGE (msmt_date);


CREATE TABLE iot.sensor_msmtt_y2021m01 PARTITION OF iot.sensor_msmt
    FOR VALUES FROM ('2021-01-01') TO ('2021-02-01’);


CREATE TABLE iot.sensor_msmtt_y2021m02 PARTITION OF iot.sensor_msmt
    FOR VALUES FROM ('2021-02-01') TO ('2021-03-01');

SELECT
  *
FROM
  generate_series(1,100) as t1;

SELECT
  *
FROM
  generate_series('2021-01-01 00:00'::timestamp,
  				  '2021-02-15 00:00'::timestamp,
  				  '1 minutes') as t2;


