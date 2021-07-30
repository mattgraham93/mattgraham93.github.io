SELECT BuildingName
	,detail.Number
	,detail.DETAILS_Title
	,items.ITEMS_DETAIL_DESC
	,items.[ITEMS_DETAIL_Account Category]
	,items.[ITEMS_FUNDING_UNIT PRICE]
  FROM FACT_Kahua_Issues_Items as items
	inner join FACT_Kahua_Issues_Detail as detail
		on items.[Issue Key] = detail.[Record Key]
	inner join Dim_ProjNoAssoc as proj
		on items.Project = proj.Kahua_BldgProjNo
where VillageName like 'Sammamish' and 
      BuildingName not in ('F', 'G', 'H', 'I', 'T')
order by number desc
