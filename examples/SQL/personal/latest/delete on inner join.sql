--delete ra
--from Fact_Build_Manual_FcstTool_RawActuals ra
--	inner join vw_CPS_ForecastActuals_Recon rec
--		on ra.project_id = rec.Project_ID and ra.Period_date = rec.period



--insert into Fact_Build_Manual_FcstTool_RawActuals (
--	project_id, Period_date, actuals
--) select Project_ID, period, BTActuals
--from vw_CPS_ForecastActuals_Recon

select * from vw_CPS_ForecastActuals_Recon


--execute [dbo].[s_pr_ProjectName_update_actuals]
--execute [dbo].[s_pr_Build_ForecastPmProj]