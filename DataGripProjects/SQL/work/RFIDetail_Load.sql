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
CREATE PROCEDURE Load_Fact_ProjRFIKahuaDetail
as

Declare  @KahuaProjNum int,
		 @ProjAssocID int;

BEGIN TRY
	BEGIN TRAN
	Declare ProjMeetingKahuaDetail CURSOR
		FOR SELECT
				[Project Niumber]
			FROM dbo.Stage_ProjMeetingKahuaDetail2
		

	OPEN ProjMeetingKahuaDetail;

			FETCH NEXT FROM ProjMeetingKahuaDetail INTO 
				@KahuaProjNum;

			print @KahuaProjNum;
			print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		FETCH NEXT FROM ProjMeetingKahuaDetail INTO 
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
			INSERT INTO Fact_ProjRFIKahuaDetail
				(
				 [Project_Key]
				  ,[Proj_Assoc_ID]
				  ,[Record_Key]
				  ,[Assigned_To]
				  ,[Workflow_Step]
				  ,[Project]
				  ,[Details_Number]
				  ,[Details_Date]
				  ,[Details_Subject]
				  ,[Details_Priority]
				  ,[Details_Status]
				  ,[Details_Author_Name]
				  ,[Details_Discipline]
				  ,[Source_RFI]
				  ,[Details_Village/Building_Name]
				  ,[Details_Cost_Effect]
				  ,[Details_Cost_Amount]
				  ,[Details_Reason]
				  ,[Details_Time_Effect]
				  ,[Details_Number_of_Days]
				  ,[Details_Activity_ID]
				  ,[Details_Question]
				  ,[Details_Proposed_Solution]
				  ,[Notification]
				  ,[Details_Response_Distribution]
				  ,[Details_Assigned_To_Days_Outstanding]
				  ,[Primary_Response_Primary_Responder]
				  ,[Primary_Response_Date_Sent]
				  ,[Primary_Response_Date_Responded]
				  ,[Primary_Response_Primary_Response]
				  ,[Created_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Load_Date]
				  ,[Due_Date]
				)
			SELECT
				[Project Key]
				,@ProjAssocID
				  ,[Record Key]
				  ,[Assigned To]
				  ,[Workflow Step]
				  ,[Project]
				  ,[DETAILS_Number]
				  ,[DETAILS_Date]
				  ,[DETAILS_Subject]
				  ,[DETAILS_Priority]
				  ,[DETAILS_Status]
				  ,[DETAILS_Author NAME]
				  ,[DETAILS_Discipline]
				  ,[Source RFI]
				  ,[DETAILS_Village/Building Name]
				  ,[DETAILS_Cost Effect]
				  ,[DETAILS_Cost Amount]
				  ,[DETAILS_Reason]
				  ,[DETAILS_Time Effect]
				  ,[DETAILS_Number of Days]
				  ,[DETAILS_Activity ID]
				  ,[DETAILS_Question]
				  ,[DETAILS_Proposed Solution]
				  ,[Notification]
				  ,[DETAILS_Response Distribution]
				  ,[DETAILS_Assigned To Days Outstanding]
				  ,[PRIMARY RESPONSE_Primary Responder]
				  ,[PRIMARY RESPONSE_Date Sent]
				  ,[PRIMARY RESPONSE_Date Responded]
				  ,[PRIMARY RESPONSE_Primary Response]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,GETDATE()
			  ,[DETAILS_DueDate]
			FROM Stage_ProjRFIKahuaDetail2
			WHERE Project = @KahuaProjNum
			end
		ELSE 
		begin

				print 'no match';
		INSERT INTO audit.Fact_ProjRFIKahuaDetail_Fail
				(
				[Project_Key]
				  ,[Proj_Assoc_ID]
				  ,[Record_Key]
				  ,[Assigned_To]
				  ,[Workflow_Step]
				  ,[Project]
				  ,[Details_Number]
				  ,[Details_Date]
				  ,[Details_Subject]
				  ,[Details_Priority]
				  ,[Details_Status]
				  ,[Details_Author_Name]
				  ,[Details_Discipline]
				  ,[Source_RFI]
				  ,[Details_Village/Building_Name]
				  ,[Details_Cost_Effect]
				  ,[Details_Cost_Amount]
				  ,[Details_Reason]
				  ,[Details_Time_Effect]
				  ,[Details_Number_of_Days]
				  ,[Details_Activity_ID]
				  ,[Details_Question]
				  ,[Details_Proposed_Solution]
				  ,[Notification]
				  ,[Details_Response_Distribution]
				  ,[Details_Assigned_To_Days_Outstanding]
				  ,[Primary_Response_Primary_Responder]
				  ,[Primary_Response_Date_Sent]
				  ,[Primary_Response_Date_Responded]
				  ,[Primary_Response_Primary_Response]
				  ,[Created_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Load_Date]
				  ,[Due_Date]
				  )
			SELECT
				[Project Key]
				,null
				  ,[Record Key]
				  ,[Assigned To]
				  ,[Workflow Step]
				  ,[Project]
				  ,[DETAILS_Number]
				  ,[DETAILS_Date]
				  ,[DETAILS_Subject]
				  ,[DETAILS_Priority]
				  ,[DETAILS_Status]
				  ,[DETAILS_Author NAME]
				  ,[DETAILS_Discipline]
				  ,[Source RFI]
				  ,[DETAILS_Village/Building Name]
				  ,[DETAILS_Cost Effect]
				  ,[DETAILS_Cost Amount]
				  ,[DETAILS_Reason]
				  ,[DETAILS_Time Effect]
				  ,[DETAILS_Number of Days]
				  ,[DETAILS_Activity ID]
				  ,[DETAILS_Question]
				  ,[DETAILS_Proposed Solution]
				  ,[Notification]
				  ,[DETAILS_Response Distribution]
				  ,[DETAILS_Assigned To Days Outstanding]
				  ,[PRIMARY RESPONSE_Primary Responder]
				  ,[PRIMARY RESPONSE_Date Sent]
				  ,[PRIMARY RESPONSE_Date Responded]
				  ,[PRIMARY RESPONSE_Primary Response]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,GETDATE()
			  ,[DETAILS_DueDate]
			FROM dbo.Stage_ProjRFIKahuaDetail2
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
