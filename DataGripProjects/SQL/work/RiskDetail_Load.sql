-- =======================================================
-- Create Stored Procedure Template for Azure SQL Database
-- =======================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:      v-magrah
-- Create Date: 03/26/2020
-- Description: loads Fact_ProjMeetingPackageKahuaDetail from Stage_ProjMeetingPackageKahuaDetail. All non-matching [Project_Number] = [Project niumber] goes to [audit].Fact_ProjSubmittalPackageKahuaDetail_Fail
-- =============================================
CREATE PROCEDURE Load_Fact_ProjRiskKahuaDetail
as

Declare  @KahuaProjNum int,
		 @ProjAssocID int;

BEGIN TRY
	BEGIN TRAN
	Declare ProjRiskKahuaDetail CURSOR
		FOR SELECT
				Project
			FROM dbo.Stage_ProjRiskKahuaDetail2
		

	OPEN ProjMeetingKahuaDetail;

			FETCH NEXT FROM ProjRiskKahuaDetail INTO 
				@KahuaProjNum;

			print @KahuaProjNum;
			print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		FETCH NEXT FROM ProjRiskKahuaDetail INTO 
			@KahuaProjNum;
		
		print 'in while loop:' + @KahuaProjNum;

		SELECT @ProjAssocID = Proj_Assoc_ID 
		from dbo.Dim_ProjNumAssoc
		where @KahuaProjNum = Kahua_Bldg_Proj_No

		print 'projassocid ' + @ProjAssocID;

		print 'projnum: '+cast(@KahuaProjNum as nvarchar(5));

	print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));


		IF (@KahuaProjNum <> NULL AND @KahuaProjNum > 0 AND @ProjAssocID <> NULL AND @ProjAssocID > 0 )
		begin
			print 'not null';
			INSERT INTO Fact_ProjRiskKahuaDetail
				(
				 [Kahua_Proj_Num]
				  ,[Risk_Key]
				  ,[Proj_Assoc_ID]
				  ,[Details_Number]
				  ,[Details_Date_Reported]
				  ,[Details_Date_Closed]
				  ,[Details_Project_Phase_at_Identification]
				  ,[Details_Risk_Description]
				  ,[Details_Responsible_Person_Name]
				  ,[Risk_Assessment_Impact_Description]
				  ,[Risk_Assessment_Risk_Categories_Impacted]
				  ,[Risk_Assessment_Impact_Severity]
				  ,[Risk_Assessment_Impact_Probability]
				  ,[Risk_Assessment_Risk_Rating]
				  ,[Risk_Assessment_Potential_Schedule_Impact]
				  ,[Risk_Assessment_Potential_Budget_Impact]
				  ,[Risk_Assessment_Actual_Schedule_Impact]
				  ,[Risk_Assessment_Actual_Budget_Impact]
				  ,[Risk_Mitigation_Risk_Status]
				  ,[Risk_Mitigation_Mitigation_Plan]
				  ,[Risk_Mitigation_Resolution_Reason]
				  ,[Risk_Mitigation_Last_Update]
				  ,[Risk_Mitigation_Timeline_to_Impact]
				  ,[Risk_Mitigation_Expected_Date_of_Impact]
				  ,[Create_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Load_Date]
				)
			SELECT
				[Project Key]
				  ,[Record Key]
				  ,@ProjAssocID
				  ,[DETAILS_Number]
				  ,[DETAILS_Date Reported]
				  ,[DETAILS_Date Closed]
				  ,[DETAILS_Project Phase at Identification]
				  ,[DETAILS_Risk Description]
				  ,[DETAILS_Responsible Person NAME]
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
				  ,[RISK MITIGATION_Expected Date of Impact]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,GETDATE()
			FROM Stage_ProjRiskKahuaDetail2
			WHERE Project = @KahuaProjNum
			end
		ELSE 
		begin

				print 'no match';
		INSERT INTO audit.Fact_ProjRiskKahuaDetail_Fail
				(
				[Kahua_Proj_Num]
				  ,[Risk_Key]
				  ,[Proj_Assoc_ID]
				  ,[Details_Number]
				  ,[Details_Date_Reported]
				  ,[Details_Date_Closed]
				  ,[Details_Project_Phase_at_Identification]
				  ,[Details_Risk_Description]
				  ,[Details_Responsible_Person_Name]
				  ,[Risk_Assessment_Impact_Description]
				  ,[Risk_Assessment_Risk_Categories_Impacted]
				  ,[Risk_Assessment_Impact_Severity]
				  ,[Risk_Assessment_Impact_Probability]
				  ,[Risk_Assessment_Risk_Rating]
				  ,[Risk_Assessment_Potential_Schedule_Impact]
				  ,[Risk_Assessment_Potential_Budget_Impact]
				  ,[Risk_Assessment_Actual_Schedule_Impact]
				  ,[Risk_Assessment_Actual_Budget_Impact]
				  ,[Risk_Mitigation_Risk_Status]
				  ,[Risk_Mitigation_Mitigation_Plan]
				  ,[Risk_Mitigation_Resolution_Reason]
				  ,[Risk_Mitigation_Last_Update]
				  ,[Risk_Mitigation_Timeline_to_Impact]
				  ,[Risk_Mitigation_Expected_Date_of_Impact]
				  ,[Create_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Load_Date]
				  )
			SELECT
				[Project Key]
				  ,[Record Key]
				  ,null
				  ,[DETAILS_Number]
				  ,[DETAILS_Date Reported]
				  ,[DETAILS_Date Closed]
				  ,[DETAILS_Project Phase at Identification]
				  ,[DETAILS_Risk Description]
				  ,[DETAILS_Responsible Person NAME]
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
				  ,[RISK MITIGATION_Expected Date of Impact]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,GETDATE()
			FROM dbo.Stage_ProjRiskKahuaDetail2
			WHERE Project = @KahuaProjNum
			end

			set @KahuaProjNum = 0;
			set @ProjAssocID = 0;
		END;
	COMMIT TRAN
END TRY
BEGIN CATCH
	IF(@@TRANCOUNT > 0)
		ROLLBACK TRAN;
END CATCH

	CLOSE ProjRiskKahuaItems;
 
	DEALLOCATE ProjRiskKahuaItems;
