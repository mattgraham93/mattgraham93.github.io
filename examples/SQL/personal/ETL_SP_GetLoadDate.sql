IF OBJECT_ID ( 'dbo.sp_GetAzureLoadDate') IS NOT NULL  
    DROP PROCEDURE dbo.sp_GetAzureLoadDate;  
GO 

create procedure sp_GetAzureLoadDate 
	@TableName varchar(250)
as
	declare @Schema varchar(50)
	declare @Query nvarchar(500)
	declare @LoadDate datetime

	set @Schema = 'dbo'

	set @Query = 'select max(AzureLoadDate) from ' + @Schema + '.' + @TableName

	declare @result table([AzureLoadDate] datetime);
	insert into @result
	exec ( @Query );

	set @LoadDate = (select * from @result)

	return convert(int, @LoadDate)
go


declare @LoadDate int
exec @LoadDate = sp_GetAzureLoadDate 'Fact_Build_ProjLinkBudget' 
select cast(@LoadDate as datetime) AzureLoadDate





