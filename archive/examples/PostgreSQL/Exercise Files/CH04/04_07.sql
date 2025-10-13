CREATE OR REPLACE FUNCTION is_palendrome (str text) RETURNS
AS $$
   SELECT reverse(str) = str
$$  LANGUAGE SQL IMMUTABLE;


SELECT is_palendrome('abccba'), is_palendrome('foobarbaz')