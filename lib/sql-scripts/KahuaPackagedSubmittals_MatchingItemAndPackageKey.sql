/****** Script for SelectTopNRows command from SSMS  ******/
SELECT si.DETAILS_Subject, sd.DETAILS_Subject, BuildingName, sd.Record_Key, si.Record_Key, si.
  FROM [RedmondCR].[dbo].[test_msft_packagedsubmittal_detail] sd
	inner join test_msft_submittalItem_detail si
		on sd.Record_Key = si.Record_Key
	inner join Dim_ProjNoAssoc as proj
		on CONCAT('K', sd.Project_Number) = proj.Kahua_BldgProjNo
