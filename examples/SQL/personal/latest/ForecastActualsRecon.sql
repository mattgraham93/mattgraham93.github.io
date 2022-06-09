SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[vw_Build_ProjectForecastActuals]
as
-- Matt Graham
-- Returns concatenated list of all actuals and forecast values that do not exist in actuals table

with c as (
	select distinct ProjectID, AssetClass, period, Amount, ForecastCycle, AzureLoadDate, 'Forecast' FinanceFunction
	from Fact_Build_Locked_ForecastTool_Data
	-- only show values that do not already have actuals in any period
	where period not in (select distinct [Fiscal Period] from vw_Fact_Build_TeamActuals)
	group by ProjectID, AssetClass, period, Amount, ForecastCycle, AzureLoadDate
	-- get latest forecast load
	having AzureLoadDate = (select MAX(azureloaddate) from Fact_Build_Locked_ForecastTool_Data)
) 
select * from c
union all
-- get all values from current Build Team Actuals
select [Project ID], [Asset Class], [Fiscal Period], Amount, 'N/A' ForecastCycle, getdate() AzureLoadDate, 'Actuals' FinanceFunction
from vw_Fact_Build_TeamActuals
GO
