/****** Script for SelectTopNRows command from SSMS  ******/
SELECT BuildingName
      ,[DETAILS_Number]
      ,[DETAILS_Date_Reported]
      ,[DETAILS_Date_Closed]
      ,[DETAILS_Project_Phase_at_Identification]
      ,[DETAILS_Risk_Description]
      ,[DETAILS_Responsible_Person_NAME]
      ,[RISK_ASSESSMENT_Impact_Description]
      ,[RISK_ASSESSMENT_Risk_Categories_Impacted]
      ,[RISK_ASSESSMENT_Impact_Severity]
      ,[RISK_ASSESSMENT_Impact_Probability]
      ,[RISK_MITIGATION_Risk_Status]
      ,[RISK_MITIGATION_Last_Update]
      ,[RISK_MITIGATON_Timeline_to_Impact]
      ,[RISK_MITIGATION_Expected_Date_of_Impact]
  FROM [RedmondCR].[dbo].[test_msft_risk_detail] rd
  	inner join Dim_ProjNoAssoc as proj
		on CONCAT('K', rd.Project) = proj.Kahua_BldgProjNo