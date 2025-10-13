------ READY TO GO
------ DELETE FROM RAW ACTUALS THAT HAVE AN ACTIVE FORECAST STATUS
------ EXPECT: 580 ROWS

delete ra
--select project_id
--	, Period_date
--	, sum(actuals) Actuals
from Fact_Build_Manual_FcstTool_RawActuals ra
	---- ONLY GET ROWS FOR WHICH CAPEX PROJECTS AND PERIODS EXIST BETWEEN IT AND RAW ACTUALS
	---- e.g. focusing on values for which we can replace
	---- are there times where a project would not be reported in capex? yes, opex.
	inner join (
		select distinct CapexProjectId, FiscalMonthYM from Fact_Build_CapexPerspective
		) cpx
		on ra.project_id = cpx.CapexProjectId 
			-- include fiscal period for appropriate mapping
			 and ra.Period_date = cpx.FiscalMonthYM
where project_id in (
	select distinct Project_ID
	from Fact_Build_Live_FcstTool_RawFcstData
	where Forecast_status like 'Y'
)
	-- include ONLY	capital, non-LCR projects that are NOT complete or cancelled
	and project_id in (
		select distinct [Project ID]
		from VW_FullProjectList
		where 
		(
			[Capital or Expense] like 'Capital' and Program not like 'LCR%'
		) 
		and 
		[Project Status] not in ('Complete', 'Cancelled')
	) or
	CapexProjectId like '208600'
--group by project_id, Period_date;



------ READY TO GO
------ INSERT PROJECT PERIOD ACTUALS TO RAW ACTUALS THAT HAVE AN ACTIVE FORECAST STATUS
------ EXPECT: 868 ROWS

with c as (
select CapexProjectId
	, FiscalMonthYM
	, sum(CapExActuals) Actuals
from Fact_Build_CapexPerspective
where CapExActuals <> 0 
	and 
	(
		CapexProjectId in (
			select distinct Project_ID
			from Fact_Build_Live_FcstTool_RawFcstData
			where Forecast_status like 'Y'
			)
		-- include ONLY capital, non-LCR projects that are NOT complete or cancelled
		and 
			CapexProjectId in (
			select distinct [Project ID]
			from VW_FullProjectList
			where 
			(
				[Capital or Expense] like 'Capital' and Program not like 'LCR%'
			) and 
			[Project Status] not in ('Complete', 'Cancelled')
			)
	)
	or CapexProjectId like '208600'
group by CapexProjectId, FiscalMonthYM
----order by CapexProjectId, FiscalMonthYM
) 
--insert into Fact_Build_Manual_FcstTool_RawActuals (
--	project_id, Period_date, actuals
--) 
select CapexProjectId, FiscalMonthYM, Actuals
from c 
where CapexProjectId not in ('104145', '104147', '103803', '104120', '104199')


---- check to see if 208600 moved correctly
select *
from Fact_Build_Manual_FcstTool_RawActuals
where project_id = '208600'


---- set 208600 to PS0021 per Teagan for correct reconciliation 
update Fact_Build_Manual_FcstTool_RawActuals
set project_id = 'PS0021'
where project_id = '208600'


---- need to execute stored procedures for Forecast Tool
exec s_pr_ProjectName_update_actuals
exec s_pr_Build_ForecastPmProj


--select project_id, Period_date, actuals from Fact_Build_Manual_FcstTool_RawActuals