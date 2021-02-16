select Village_Name
	,cast(sum(Estimate_at_Completion) as int) as Estimate_At_Completion
	,cast(SUM(Effective_Baseline) as int) as Effective_Baseline
	,cast(SUM(Committed_to_Date) as int) as Commited_To_Date
from Fact_FinTstpBCTBdgt
where Check_In_ID like 'CI8%'
group by Village_Name
