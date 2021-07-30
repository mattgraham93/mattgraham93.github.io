select il.Project_Key
	,il.Location_Key
	,il.Issue_Key
	,det.DETAILS_Title
	,proj.BuildingName as KahuaProjectName
	,loc.Location_Name as AffectedScope
  FROM [RedmondCR].[dbo].[TEST_msft_issues_locations] il
	inner join TEST_msft_locations loc
		on il.Location_Key = loc.Location_Key
	inner join TEST_msft_issues_detail det
		on il.Issue_Key = det.Record_Key
	inner join Dim_ProjNoAssoc proj
		on loc.Project_Key = proj.Kahua_BldgProjNo