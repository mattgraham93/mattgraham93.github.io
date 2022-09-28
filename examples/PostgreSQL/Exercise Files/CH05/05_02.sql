CREATE EXTENSION bloom


CREATE INDEX idx_locations_blm 
	ON locations USING bloom (city,state_province,country)


CREATE INDEX idx_locations_blm 
	ON locations USING bloom (city,state_province,country)
	WITH (length=128);


