--Populate temp table C with fields from TSTP_BCTBgt to map to Fact_EACbyCI
--We join C with Dim_FinActivityCode on Sub_Activity and WBSProjectCode, rendering unique returns.

with C as (
	select 
	[WBS Object], 
	SUBSTRING([WBS Object],1,2) as CostConstructionCode,
	SUBSTRING([WBS Object],10,6) as WBSAccountingCode,
	SUBSTRING([WBS Object],22,6) as WBSProjectCode,
	[Asset Class],
	Budget,
	Effective_Baseline,
	Estimate_at_Completion,
	CheckInID,
	Sub_Activity,
	Activity
from vw_TSTP_BCTBgt)

select C.CostConstructionCode, C.WBSAccountingCode, C.WBSProjectCode, C.[Asset Class], C.Budget, C.Effective_Baseline, C.Estimate_at_Completion, C.CheckInID, Dim_FinActivityCode.ActivityCode, Dim_FinActivityCode.SubActivityCode
from C
left outer join Dim_FinActivityCode
	on C.WBSProjectCode = Dim_FinActivityCode.WBSProjectCode AND C.Sub_Activity = Dim_FinActivityCode.SubActivityName
