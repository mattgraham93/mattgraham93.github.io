select proj.BuildingName as KahuaProjectName
	,rd.DETAILS_Number
	,CAST(LEFT(rd.DETAILS_Date_Reported,10) as date) DateReported
	,CAST(LEFT(rd.DETAILS_Date_Closed,10) as date) DateClosed
	,rd.DETAILS_Project_Phase_at_Identification
	,rd.DETAILS_Risk_Description
	,rd.DETAILS_Responsible_Person_NAME
	,rd.RISK_ASSESSMENT_Impact_Description
	,rd.RISK_ASSESSMENT_Risk_Categories_Impacted
	,rd.RISK_ASSESSMENT_Impact_Severity
	,rd.RISK_ASSESSMENT_Impact_Probability
	,rd.RISK_ASSESSMENT_Risk_Rating
	,rd.RISK_ASSESSMENT_Potential_Schedule_Impact_in_weeks
	,rd.RISK_ASSESSMENT_Potential_Budget_Impact
	,rd.RISK_ASSESSMENT_Actual_Schedule_Impact_in_weeks
	,rd.RISK_ASSESSMENT_Actual_Budget_Impact
	,rd.RISK_MITIGATION_Risk_Status
	,rd.RISK_MITIGATION_Mitigation_Plan
	,rd.RISK_MITIGATION_Resolution_Reason
	,CAST(LEFT(rd.RISK_MITIGATION_Last_Update,10) as date) LastUpdate
	,rd.RISK_MITIGATON_Timeline_to_Impact
	,CAST(LEFT(rd.RISK_MITIGATION_Expected_Date_of_Impact,10) as date) ExpectedDateOfImpact
  from TEST_msft_risk_detail rd
	inner join Dim_ProjNoAssoc proj
		on rd.Project = proj.Kahua_BldgProjNo
	where DETAILS_Responsible_Person_NAME not in ('Matt Graham') or DETAILS_Responsible_Person_NAME is null