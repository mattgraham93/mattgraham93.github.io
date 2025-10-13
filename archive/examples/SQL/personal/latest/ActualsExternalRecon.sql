SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER view [dbo].[vw_CPS_ActualsRecon]
as
-- Summarize forecast and actual spend CTE table
	with comp_union as (
		-- get reported actuals
		select 
		bta.[Project ID] 
		, bta.[Fiscal Period]
		, sum(bta.Amount) 'Amount'
		, 'BT actuals' 'Source'
		from vw_Fact_Build_TeamActuals bta
		group by bta.[Project ID], bta.[Fiscal Period]
		union all
		-- get capex actuals
		select 
		cic.[Project ID]
		, cic.[Fiscal Period]
		, sum(cic.Amount) 'Amount'
		, 'CAPEX actuals' 'Source'
		from vw_CPS_IW_CAPEXActuals cic
		group by cic.[Project ID], cic.[Fiscal Period]
		union all
		-- get forecast tool values
		select ra.project_id,
		ra.Period_date,
		sum(ra.actuals) 'Amount',
		'Forecast actuals' 'Source'
		from Fact_Build_Manual_FcstTool_RawActuals ra
		group by ra.project_id, ra.Period_date
	), 
		-- create pivot table to track CAPEX vs. BT actuals based on period and project
		comp_pvt as (
		-- select final items to display
		select [Project ID], [Fiscal Period], [BT actuals], [Capex actuals], [Forecast actuals]
		from 
			-- isolate project IDs, reporting periods, and 'n' ValueTypes as columns
			(select [Project ID], [Fiscal Period], Amount, Source from comp_union) p
		pivot (
			-- since we summarized already, no need for more. get the reported value for each value type
			max(Amount)
			for Source in ([BT actuals], [Capex actuals], [Forecast actuals])
	) as pvt),

	agg as (
		-- get all projects, fiscal periods, and BT/CAPEX actuals
		select [Project ID] 'ProjectID'
		, [Fiscal Period]
		, case when [BT actuals] is null then 0
			else [BT actuals]
			end 'BT actuals'
		, case when [Capex actuals] is null then 0
			else [Capex actuals]
			end 'Capex actuals'
		, case when [Forecast actuals] is null then 0
			else [Forecast actuals]
			end 'Forecast actuals'
		from comp_pvt
	)
	select 
		agg.*
		, [BT actuals] - [Capex actuals] 'BT actuals variance'
		, [BT actuals] - [Forecast actuals] 'Forecast actuals variance'
		, pl.*
		, d.Clientfiscalquarter
		, d.Clientfiscalyear
		, d.Clientfiscalperiod
		, d.Month
		, d.Monthtext
		, d.Calendaryearmonth
		, d.Year
	from agg
		left join VW_FullProjectList pl
			on agg.[ProjectID] = pl.[Project ID]
		left join (select distinct Clientperiod, Clientfiscalquarter, Clientfiscalyear, Clientfiscalperiod, Month, Monthtext, Calendaryearmonth, Year from Dim_Build_Date) d
			on agg.[Fiscal Period] = d.Clientperiod
	where agg.[ProjectID] is not null

GO
