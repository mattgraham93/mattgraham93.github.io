select 
	case when b.[Record Key] is null 
		then 'Submittal Item'
	else 'Submittal Package'
	end as 'Submittal Identity'
	, a.DETAILS_Number Submittal_Item_Number
	, b.DETAILS_Number Submittal_Package_Number
	, a.DETAILS_Subject Submittal_Item_Subject
	, b.DETAILS_Subject Submittal_Record_Subject
	, BuildingName as Kahua_Project_Name
from FACT_Kahua_SubmittalItem_Detail a
	left join FACT_Kahua_SubmittalPackage_Detail b
		on a.[Submittal Record Key] = b.[Record Key]
	inner join Dim_ProjNoAssoc c
		on a.Project = c.Kahua_BldgProjNo