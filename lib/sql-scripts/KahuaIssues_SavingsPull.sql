--Meeting items that are savings after 7/26/2019 (100% DD tollgate)
SELECT r.DETAILS_Title
	,l.[Issue Key]
	, r.[DETAILS_Date_Closed]
	, r.Number
	,DETAILS_Description
    ,CAST(LEFT([DETAILS_Due_Date],10) as date) as DueDate
	, BuildingName as KahuaProjectLocation
	, lo.Location_Name as AffectedLocation
	, l.ITEMS_DETAIL_DESC
	, DETAILS_Status
	, l.[ITEMS_DETAIL_Account Category]
	, l.[ITEMS_FUNDING_UNIT PRICE]
	, l.ITEMS_FUNDING_QTY
  FROM FACT_Kahua_Issues_Items as l
	inner join FACT_Kahua_Issues_Detail as r
		on l.[Issue Key] = r.[Record_Key]
	inner join Dim_ProjNoAssoc
		on l.Project = Dim_ProjNoAssoc.Kahua_BldgProjNo
	inner join FACT_Kahua_Locations lo
		on r.location_id = lo.Location_Key
where 
	DETAILS_Title like 'Savings%' 
	and (CAST(LEFT([DETAILS_Date_Closed],10) as datetime) > '7/26/2019' 
		OR [DETAILS_Date_Closed] is null) 
	and DETAILS_Status like 'Approved-Closed'
	and lo.Location_Name like 'Building T%'
order by Number


---- Unvalidated savings query
select sum(
	case when l.[ITEMS_FUNDING_UNIT PRICE] is null 
		then 0 
			else abs(cast(l.[ITEMS_FUNDING_UNIT PRICE] as decimal(10,2)))
	end) as TotalSavings
FROM FACT_Kahua_Issues_Items as l
	inner join FACT_Kahua_Issues_Detail as r
		on l.[Issue Key] = r.[Record_Key]
	inner join Dim_ProjNoAssoc
		on l.Project = Dim_ProjNoAssoc.Kahua_BldgProjNo
	inner join FACT_Kahua_Locations lo
		on r.location_id = lo.Location_Key
where 
	DETAILS_Title like 'Savings%' 
	and (CAST(LEFT([DETAILS_Date_Closed],10) as datetime) > '7/26/2019' 
		OR [DETAILS_Date_Closed] is null) 
	and DETAILS_Status like 'Approved-Closed'
	and lo.Location_Name like 'Building T%'
--group by VillageName
