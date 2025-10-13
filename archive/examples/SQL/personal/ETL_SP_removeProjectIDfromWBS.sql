IF OBJECT_ID (N'dbo.uFnRemoveProjectFromWBSCode', N'FN') IS NOT NULL  
    DROP FUNCTION ufnGetInventoryStock;  
GO  
create function uFnRemoveProjectFromWBSCode (@Project varchar(250))
returns varchar(250)
as
begin
	declare @WBSCode varchar(250)
		if patindex('%[a-Z]%', @Project) > 0 and len(@Project) < 11
			set @WBSCode = null
		if len(@Project) >= 11 and len(replace(@Project, '.', '')) <= 20
			set @WBSCode = concat(left(@Project, 3),substring(@Project, 10, 15))		
	return @WBSCode
end