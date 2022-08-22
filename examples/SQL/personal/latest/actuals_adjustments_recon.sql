alter view vw_CPS_ForecastActuals_Recon
as 

-- created by: Matt Graham
-- 8/17/2022

-- this view aggregates all reported spend between various systems
-- if projects with live forecasts have an imbalance of reported spend between systems
-- this returns all projects, periods, programs, statuses, PMs, and completion dates for each discrepancy
-- this is used by sp_Update_ForecastActuals

with forecast_spend as (
	-- get manually copied actuals, by project and reporting period displayed in forecast tool, assign ValueType, 
	select case when rfd.Project_ID is null then cast(rfd.SAP_Number as nvarchar) else rfd.project_id end 'Project_ID',
		rfd.Period_date 'period', 
		sum(rfd.actuals) ForecastAmount,
		'RawActuals' ValueType
	from [Fact_Build_Manual_FcstTool_RawActuals] rfd
	group by rfd.Project_ID, rfd.Period_date, rfd.SAP_Number
	union all
	-- get all BT actuals by project and reporting period, assign ValueType
	select case when bta.[Project ID] is null then bta.[SAP Number] else bta.[Project ID] end 'Project_ID', 
		bta.[Fiscal Period],
		sum(bta.Amount) ActualSpend,
		'BTActuals' ValueType
	from vw_Fact_Build_TeamActuals bta
	group by bta.[Project ID], bta.[Fiscal Period], bta.[SAP Number]
	union all
	-- get all adjustments (primarily for further financial diagnosis)
	select case when cpx.[CapexProjectId] is null then cpx.[SAPPSProjectID] else cpx.[CapexProjectID] end 'Project_ID',
		cpx.FiscalMonthYM,
		sum(cpx.CapExActuals) ActualSpend,
		'CAPEX' ValueType
	from Fact_Build_CapexPerspective cpx
    where cpx.CapExActuals <> 0
	group by cpx.[CapexProjectId], cpx.[FiscalMonthYM], cpx.[SAPPSProjectID]
), 
	-- create pivot table to track raw actual vs. BT actuals, and adjustments based on project/period
	forecast_pvt as (
	-- select final attributes to display
	select Project_ID, period, RawActuals, BTActuals, CAPEX
	from 
		-- isolate project IDs, reporting periods, and ValueType as columns
		(select Project_ID, period, ForecastAmount, ValueType from forecast_spend) p
	pivot (
		-- since we summarized already, no need for more. 
		-- get the reported value for each value type as noted in forecast_spend
		max(ForecastAmount)
		for ValueType in (RawActuals, BTActuals, CAPEX)
) as pvt), 
c as (
	-- get all projects, reporting periods, forecast, and spend values and reporting date for use in Power BI
	-- note that all projects will be the intersection of projects with a live forecast status 
	-- AND projects that have any reported actual spend
	select Project_ID
		, period
		, case when RawActuals is null then 0 else RawActuals end 'RawActuals' -- set to 0 for calculations. null values do not return a zero by default
		, case when BTActuals is null then 0 else BTActuals end 'BTActuals'
		, case when CAPEX is null then 0 else CAPEX end 'CAPEX'
		, ddate.SQLDate [ReportingDate] from forecast_pvt -- can be added back in to select from d if needed for time series reporting
		-- join on client period, get the last sql date by reporting period to return for querying
		left join (select distinct Clientperiod, LAST_VALUE(SQLdate) over (partition by Clientperiod order by Clientperiod) SQLDate from Dim_Build_Date) ddate
			on forecast_pvt.period = ddate.Clientperiod
		), d as (
			select project_id
			, period
			, RawActuals
			, BTActuals
			, CAPEX
			, BTActuals - RawActuals as BT_Act_Raw_Act_Diff -- calculate difference between BT and raw actuals
			, CAPEX - RawActuals as Raw_Act_Diff_CAPEX -- calculate difference between adjustments and diff. if 0 or 2n, consider looking into duplicate entry
			, CAPEX - BTActuals as BT_Act_Diff_CAPEX
			from c
		),
		f as 
		-- Get all projects with a live forecast status
			(select * 
			from d
			where 
				-- cleaning up what is returned
				(d.project_id is not null or d.project_id not like ' ' or d.project_id not like ' ')
				and
				-- get values that have a "significant" difference. this accounts for float error
				(
					(d.BT_Act_Raw_Act_Diff < -2 or d.BT_Act_Raw_Act_Diff > 2) 
					OR
					(d.BT_Act_Diff_CAPEX < -2 or d.BT_Act_Diff_CAPEX > 2)
					OR
					(d.Raw_Act_Diff_CAPEX < -2 or d.Raw_Act_Diff_CAPEX > 2)
				)
				-- return projects that have an active forecast status
				and Project_ID in (select distinct fc.Project_ID from Fact_Build_Live_FcstTool_RawFcstData fc where Forecast_status like 'Y')
			), 
			-- filter for specific projects
			g as (
				select distinct Project_ID
				, period
				, BTActuals
				, RawActuals
				, BT_Act_Raw_Act_Diff
				, CAPEX
				, BT_Act_Diff_CAPEX
				, Raw_Act_Diff_CAPEX
				, fpl.[Project Name]
				, fpl.[Project Status]
				, fpl.[CBRE Project Manager]
				, fpl.Program
				, fpl.[Construction Complete DtC/O]
				, fpl.[SAP Number]
				, fpl.[Capital or Expense]
				from f
					left join VW_FullProjectList fpl
						on f.Project_ID = fpl.[Project ID]
				-- where left([period], 4) in ('2022', '2023')
				where left([Project ID], 1) not in ('1', 'P')
				and Program not like 'LCR%'
				and [Capital or Expense] like 'Capital'
				) 
				-- only get values for which spend exists in prior fiscal periods
				select * from g
				group by 
				Project_ID
				, period
				, BTActuals
				, RawActuals
				, BT_Act_Raw_Act_Diff
				, [Project Name]
				, [Project Status]
				, [CBRE Project Manager]
				, Program
				, [Construction Complete DtC/O]
				, [SAP Number]
				, CAPEX -- debugging
				, BT_Act_Diff_CAPEX
				, Raw_Act_Diff_CAPEX
				, [Capital or Expense]
				-- we always run the next month's accrual and it displays in BT actuals. we will only return values that are NOT the max (next) reporting period
				having period not in (select max(cast([Fiscal Period] as int)) from vw_Fact_Build_TeamActuals)