--Packaged submittals updated view
select BuildingName
      ,detail.DETAILS_Number Number
      ,detail.DETAILS_Revision_No RevNo
      ,detail.DETAILS_Subject PackageSubject
	  ,detail.DETAILS_Description Description
      ,detail.DETAILS_Status Status
      ,detail.DETAILS_Submittal_Coordinator_NAME Owner
      ,detail.DETAILS_CSI_Code PackageCSICode
      ,detail.DETAILS_Official_Reviewer OfficialReviewer
	  ,detail.DETAILS_Review_Period_days
      ,detail.DETAILS_Date_Submitted_to_Reviewer DateSubmittedToReviewer
      ,detail.DETAILS_Offical_Response_Date DateOfficialResponse
	  ,CSI_Code ItemCSICode
	  ,item.DETAILS_Subject ItemSubject
	  ,(select COUNT(*) 
		from TEST_msft_submittalItem_detail as item
		where detail.Record_Key = item.Record_Key) ItemCount
	  ,case
			when DATEDIFF(DAYOFYEAR, CAST(LEFT(detail.DETAILS_Date_Submitted_to_Reviewer, 10) as date), CAST(LEFT(detail.DETAILS_Offical_Response_Date,10) as date)) > CAST(detail.DETAILS_Review_Period_days as int)
				AND detail.DETAILS_Status not like 'Completed'
					then 'Overdue'
			when detail.DETAILS_Status like 'Completed'
				then 'Complete'
			else 'Active'
		end SubmittalStatus
	   ,DATEDIFF(DAYOFYEAR, CAST(LEFT(detail.DETAILS_Date_Submitted_to_Reviewer, 10) as date), CAST(LEFT(detail.DETAILS_Offical_Response_Date,10) as date)) DaysActive
from test_msft_packagedsubmittal_detail detail
	inner join Dim_ProjNoAssoc proj
		on detail.Project_Number = proj.Kahua_BldgProjNo
	left join TEST_msft_packagedsubmittal_csi_codes csi
		on detail.Record_Key = csi.Submittal_Record_Key
	left join TEST_msft_submittalItem_detail as item
		on detail.Record_Key = item.Record_Key