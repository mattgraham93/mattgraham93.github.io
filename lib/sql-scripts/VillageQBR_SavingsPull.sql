select 
	b.VillageName,
	SUM(cast(Amount as float)) as Savings
from FACT_Kahua_Issues_Detail a
	inner join Dim_ProjNoAssoc b
		on a.Project = b.Kahua_BldgProjNo
where IssueType like '%Saving%'
group by VillageName