

CREATE FUNCTION harmonic_mean (x numeric, y numeric) RETURNS numeric 
AS $$
    SELECT 
	round(((2 * x * y) / (x + y))::numeric,2) 
$$ LANGUAGE SQL;


SELECT harmonic_mean(1,2)