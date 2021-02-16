create view vw_KahuaIssues
as select
	kid.[Record Key]
	,kid.Number
	,kid.DETAILS_Title
	,kid.DETAILS_Description
	,kid.DETAILS_Status
	,kid.[DETAILS_Decision Level]
	,kid.[DETAILS_Primary Assignee]
	,kid.DETAILS_Decider
	,kid.[DETAILS_Date Opened]
	,kid.[DETAILS_Due Date]
	,kid.[DETAILS_Date Closed]
	,kid.[DETAILS_Decision Outcome]
	,kid.DETAILS_Comments
	,kid.ModifiedDateTime
	,kid.IssueType
	,kid.Amount
	,pna.BuildingName
	,pna.VillageName
	,kl.[Location Name] as 'Impacts'
from FACT_Kahua_Issues_Detail kid
	left join FACT_Kahua_Issues_Location kil
		on kid.[Record Key] = kil.[Issue Key]
	left join DIM_Kahua_Location kl
		on kil.[Location Key] = kl.[Location Key]
	inner join Dim_ProjNoAssoc pna
		on kid.Project = pna.Kahua_BldgProjNo