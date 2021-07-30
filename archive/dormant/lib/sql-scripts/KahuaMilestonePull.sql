/****** Script for SelectTopNRows command from SSMS  ******/
SELECT BuildingName
      ,[Project]
      ,[DETAILS_Description]
      ,[DETAILS_Estimated_Start_Date]
      ,[DETAILS_Estimated_Completion_Date]
      ,[DETAILS_Revised_Start_Date]
      ,[DETAILS_Revised_Completion_Date]
      ,[DETAILS_Actual_Start_Date]
      ,[DETAILS_Actual_Completion_Date]
      ,[DETAILS_Notes]
      ,[DETAILS_Responsible_Person]
  FROM [RedmondCR].[dbo].[test_msft_milestone_extract]
	inner join Dim_ProjNoAssoc
		on CONCAT('K', Project) = Kahua_BldgProjNo
where BuildingName not like 'L'