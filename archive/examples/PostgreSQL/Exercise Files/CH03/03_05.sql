with sensor_ids as
 (select i from generate_series(1,100) as i)
select
   i as id, 'Sensor ' || i::text as sensor_name
from
   sensor_ids



create table iot.sensors as
(with id_series as
 (select i from generate_series(1,100) as i)
select
   i as id, 'Sensor ' || i::text as sensor_name
from
   id_series);



explain select 
   s.sensor_name,
   sm.msmt_date,
   sm.temperature,
   sm.humidity
from
   iot.sensor_msmt as sm
left join
   iot.sensors as s 
on
  sm.sensor_id = s.id;


explain select 
   s.sensor_name,
   sm.msmt_date,
   sm.temperature,
   sm.humidity
from
   iot.sensor_msmt as sm
left join
   iot.sensors as s 
on
  sm.sensor_id = s.id
where
  s.id = 30;


