select Project_Status, count(Project__Insight__Project__ID)projCount, format(sum(FM_Project__Descriptors_Current__Total__PM_Estimate),'N0')TPV--, format(sum(cast(amount as decimal)),'N0')TPV
from(
select 
	FM_Project__Descriptors_Current__Total__PM_Estimate,
	I.Project__Insight__Project__ID--,
	--FM_Project__Descriptors_MS_Region--,amount
	,Project_Status
from (select distinct created,Project_Status,FM_Project__Descriptors_MS_Region,FM_Project__Descriptors_Current__Total__PM_Estimate,Project__Insight__Project__ID from snp.Project_Information_20210930) I
left join snp.Project_Milestones_20210930 c on c.Project__Insight__Project__ID = I.Project__Insight__Project__ID
--left join BuildTeamReportingPlatform.dbo.Final_Accruals A on A.[Project Insight ID] = I.Project__Insight__Project__ID
where   

(FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')  
and(
	Project_Status in('Under Development', 'Active')
	 and FM_Project__Descriptors_Current__Total__PM_Estimate >5
 )
) x
group by Project_Status 
