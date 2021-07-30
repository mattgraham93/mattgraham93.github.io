/****** Script for SelectTopNRows command from SSMS  ******/
SELECT b.VillageName as KahuaProjectName
      ,[DETAILS_Number]
      ,cast(left([DETAILS_Date Reported],10) as date) as DETAILS_Date_Reported
      ,[DETAILS_Date Closed]
      ,[DETAILS_Project Phase at Identification]
      ,[DETAILS_Risk Description]
      ,[RISK ASSESSMENT_Impact Description]
      ,[RISK ASSESSMENT_Risk Categories Impacted]
      ,[RISK ASSESSMENT_Impact Severity]
      ,[RISK ASSESSMENT_Impact Probability]
      ,[RISK ASSESSMENT_Risk Rating]
      ,[RISK ASSESSMENT_Potential Schedule Impact (in weeks)]
      ,[RISK ASSESSMENT_Potential Budget Impact]
      ,[RISK ASSESSMENT_Actual Schedule Impact (in weeks)]
      ,[RISK ASSESSMENT_Actual Budget Impact]
      ,[RISK MITIGATION_Risk Status]
      ,[RISK MITIGATION_Mitigation Plan]
      ,[RISK MITIGATION_Resolution Reason]
      ,[RISK MITIGATION_Last Update]
      ,[RISK MITIGATON_Timeline to Impact]
      ,cast(left([RISK MITIGATION_Expected Date of Impact], 10) as date) as [RISK MITIGATION_Expected Date of Impact]
      ,cast(left([CreatedDateTime], 10) as date) as [CreatedDateTime]
      ,cast(left([ModifiedDateTime], 10) as date) as [ModifiedDateTime]
  FROM [RedmondCR].[dbo].[FACT_Kahua_Risk_Detail] rd
	inner join Dim_ProjNoAssoc pa
		on rd.Project  = pa.Kahua_BldgProjNo
	inner join Dim_Building b
		on pa.BuildingID = b.BuildingID
