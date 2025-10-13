/****** Object:  View [dbo].[vw_CPS_LCR_SpendForecast]    Script Date: 2/15/2022 9:15:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[vw_CPS_LCR_SpendForecast]
as

-- Matt Graham
-- 12/22/21
-- This view summarizes reported forecasted spend by client fiscal period with reported actual spend

-- Summarize forecast and actual spend CTE table
with forecast_spend as (
	-- get locked forecast values by project and reporting period, summarize and assign ValueType to pivot
	select ltd.ProjectID, 
		ltd.period, 
		sum(ltd.Amount) ForecastAmount,
		'Forecast' ValueType,
		ForecastCycle Version
	from Fact_Build_Locked_ForecastTool_Data ltd
	where AzureLoadDate = (select max(AzureLoadDate) from Fact_Build_Locked_ForecastTool_Data)
	group by ltd.ProjectID, ltd.period, ltd.ForecastCycle
	union all
	-- get historical forecast values
	select rfd.Project_ID, 
		rfd.Fiscal_period, 
		sum(rfd.Period_Total) ForecastAmount,
		'Forecast' ValueType, 
		'Historical' Version
	from Fact_Build_FcstTool_Historical_RawFcstData rfd
	group by rfd.Project_ID, rfd.Fiscal_period
	
	-- join with actuals
	union all
	-- get all reported actuals by project and reporting period, assign ValueType
	select bta.[Project ID],
		bta.[Fiscal Period],
		sum(bta.Amount) ActualSpend,
		'ActualSpend' ValueType,
		'LiveSpend' Version
	from vw_Fact_Build_TeamActuals bta
	group by bta.[Project ID], bta.[Fiscal Period]
), 
	-- create pivot table to track Forecast vs. Spend based on period
	forecast_pvt as (
	-- select final items to display
	select ProjectID, period, [Forecast], [ActualSpend], Version
	from 
		-- isolate project IDs, reporting periods, and 'n' ValueTypes as columns
		(select ProjectID, period, ForecastAmount, ValueType, Version from forecast_spend) p
	pivot (
		-- since we summarized already, no need for more. get the reported value for each value type as noted in forecast_spend
		max(ForecastAmount)
		for ValueType in ([Forecast], [ActualSpend])
) as pvt)
	-- get all projects, reporting periods, forecast, and spend values and reporting date for use in Power BI
	select ProjectID, period, Forecast, ActualSpend, ddate.SQLDate [ReportingDate] from forecast_pvt
		-- join on client period, get the last sql date by reporting period to return for querying
		left join (select distinct Clientperiod, LAST_VALUE(SQLdate) over (partition by Clientperiod order by Clientperiod) SQLDate from Dim_Build_Date) ddate
			on forecast_pvt.period = ddate.Clientperiod
	--	left join vw_CPS_PERReport pl
	--		on forecast_pvt.ProjectID = pl.[Project ID]
	--where pl.[MS Region] like '%Lifecycle%Renewal%'
GO


