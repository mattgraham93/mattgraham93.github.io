explain select 
 * 
from
  iot.sensor_msmt
where
  sensor_id between 10 and 20;


create index idx_sensor_msmt_id on iot.sensor_msmt(sensor_id);


explain select 
 * 
from
  iot.sensor_msmt
where
  sensor_id between 10 and 20;



