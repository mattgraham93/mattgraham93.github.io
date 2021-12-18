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
-- Description: loads Fact_ProjIssuesKahuaDetail from Stage_ProjIssuesKahuaDetail. All non-matching [Project_Number] = [Project niumber] goes to [audit].Fact_ProjIssuesKahuaDetail
-- =============================================
CREATE PROCEDURE Load_Fact_ProjIssueKahuaDetail
as

Declare  @KahuaProjNum int,
		 @ProjAssocID int;

BEGIN TRY
	BEGIN TRAN
	Declare ProjIssuesKahuaDetail CURSOR
		FOR SELECT
				Project
			FROM dbo.Stage_ProjIssuesKahuaDetail2
		

	OPEN ProjMeetingKahuaDetail;

			FETCH NEXT FROM ProjIssuesKahuaDetail INTO 
				@KahuaProjNum;

			print @KahuaProjNum;
			print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		FETCH NEXT FROM ProjIssuesKahuaDetail INTO 
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
			INSERT INTO Fact_ProjIssuesKahuaDetail
				(
				 [Issue_Record_Key]
				  ,[Project_Key]
				  ,[Proj_Assoc_ID]
				  ,[Kahua_Proj_Num]
				  ,[Details_Title]
				  ,[Details_Description]
				  ,[Details_Status]
				  ,[Details_Decision_Level]
				  ,[Details_Decision_Memo]
				  ,[Location_Key]
				  ,[Details_Primary_Assignee]
				  ,[Details_Date_Opened]
				  ,[Details_Decider]
				  ,[Details_Due_Date]
				  ,[Details_Date_Closed]
				  ,[Details_Decision_Outcome]
				  ,[Details_Comments]
				  ,[Summary_Total]
				  ,[Created_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Issue_Type]
				  ,[Amount]
				  ,[Load_Date]
				)
			SELECT
				[Project Key]
			  ,[Record Key]
			  ,@ProjAssocID
			  ,[Number]
			  ,[DETAILS_Title]
			  ,[DETAILS_Description]
			  ,[DETAILS_Status]
			  ,[DETAILS_Decision Level]
			  ,[DETAILS_Decision Memo]
			  ,[location_id]
			  ,[DETAILS_Primary Assignee]
			  ,[DETAILS_Date Opened]
			  ,[DETAILS_Decider]
			  ,[DETAILS_Due Date]
			  ,[DETAILS_Date Closed]
			  ,[DETAILS_Decision Outcome]
			  ,[DETAILS_Comments]
			  ,[SUMMARY_TOTAL]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,[IssueType]
			  ,[Amount]
			  ,GETDATE()
			FROM Stage_ProjIssuesKahuaDetail2
			WHERE Project = @KahuaProjNum
			end
		ELSE 
		begin

				print 'no match';
		INSERT INTO audit.Fact_ProjIssuesKahuaDetail_Fail
				(
				[Issue_Record_Key]
				  ,[Project_Key]
				  ,[Proj_Assoc_ID]
				  ,[Kahua_Proj_Num]
				  ,[Details_Title]
				  ,[Details_Description]
				  ,[Details_Status]
				  ,[Details_Decision_Level]
				  ,[Details_Decision_Memo]
				  ,[Location_Key]
				  ,[Details_Primary_Assignee]
				  ,[Details_Date_Opened]
				  ,[Details_Decider]
				  ,[Details_Due_Date]
				  ,[Details_Date_Closed]
				  ,[Details_Decision_Outcome]
				  ,[Details_Comments]
				  ,[Summary_Total]
				  ,[Created_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Issue_Type]
				  ,[Amount]
				  ,[Load_Date]
				  )
			SELECT
				[Project Key]
			  ,[Record Key]
			  ,@ProjAssocID
			  ,[Number]
			  ,[DETAILS_Title]
			  ,[DETAILS_Description]
			  ,[DETAILS_Status]
			  ,[DETAILS_Decision Level]
			  ,[DETAILS_Decision Memo]
			  ,[location_id]
			  ,[DETAILS_Primary Assignee]
			  ,[DETAILS_Date Opened]
			  ,[DETAILS_Decider]
			  ,[DETAILS_Due Date]
			  ,[DETAILS_Date Closed]
			  ,[DETAILS_Decision Outcome]
			  ,[DETAILS_Comments]
			  ,[SUMMARY_TOTAL]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,[IssueType]
			  ,[Amount]
			  ,GETDATE()
			FROM dbo.Stage_ProjIssuesKahuaDetail2
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
