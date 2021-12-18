-- Create fiscal period (FP) to tie to view
with c as (
	select distinct 
		concat([Fiscal Year], [Fiscal Period]) FP, 
		cast(CONCAT([Calendar Year],'-', [Calender Period], '-01') as date) CYDate
	from vw_Build_Dim_Date
)
-- Join fiscal period to obtain calendar date for where clause
select rp.ResourceTitle, 
	rp.EmployeeName, 
	rp.ProjectID, 
	rp.WorkHrsPerMo, 
	rp.FiscalPeriod, 
	rp.PercentWorkHrs, 
	rp.NumWorkHrs,
	rp.CostWorkHrs, 
	rp.AzureLoadDate
from Stage_Build_ResourcePlanning rp
	inner join c
		on rp.FiscalPeriod = c.FP
-- Get calendar dates beyond today
--where CYDate > GETDATE()
order by ProjectID, FiscalPeriod


/*
	TODO:
		-- Insert into Fact table
			-- Index values when passing to Fact
		-- Update based on Index?
		-- Delete from Fact if not existant in Stage (separate sproc called in this?)
			-- Think: only keep rows that exist in Stage, drop rest in fact
				-- How does this tie with index?
				-- Do we need index?
*/