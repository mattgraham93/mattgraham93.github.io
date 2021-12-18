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
-- Description: loads Fact_ProjSubmittalPackageKahuaDetail from Stage_ProjSubmittalPackageKahuaDetail. All non-matching [Project_Number] = [Project number] goes to [audit].Fact_ProjSubmittalPackageKahuaDetail_Fail
-- =============================================
CREATE PROCEDURE Load_Fact_ProjSubmittalPackageKahuaDetail
as

Declare  @KahuaProjNum int,
		 @ProjAssocID int;

BEGIN TRY
	BEGIN TRAN
	Declare ProjSubmittalPackageKahuaDetail CURSOR
		FOR SELECT
				[Project number]
			FROM dbo.Stage_ProjSubmittalPackageKahuaDetail3
		

	OPEN ProjSubmittalPackageKahuaDetail;

			FETCH NEXT FROM ProjSubmittalPackageKahuaDetail INTO 
				@KahuaProjNum;

			print @KahuaProjNum;
			print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));

	WHILE @@FETCH_STATUS = 0
		BEGIN
		
		FETCH NEXT FROM ProjSubmittalPackageKahuaDetail INTO 
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
			INSERT INTO Fact_ProjSubmittalPackageKahuaDetail
				(
			    [Project_Key],
				[Project_Number],
				[Record_Key],
				[Details_Number],
				[Details_Revision_No],
				[Details_Subject],
				[Details_Description],
				[Details_Track_Items_With_Package],
				[Details_Status],
				[Details_Submittal_Coordinator_Name],
				[Details_Notes],
				[Details_Official_Reviewer],
				[Details_Instructions_to_Official_Reviewer],
				[Details_Submission_Due_From_Vendor],
				[Details_Date_Submitted_By_Vendor],
				[Details_Send_to_Official_Reviewer_By],
				[Details_Date_Submitted_to_Reviewer],
				[Details_Date_Submitted_to_Owners_Rep],
				[Details_Review_Period],
				[Details_Response_Due_Date],
				[Details_Offical_Response_Date],
				[Details_Date_Returned_to_Vendor],
				[Created_Date_Time],
				[Modified_Date_Time],
				[ProjAssocID],
				[Load_Date]
				)
			SELECT
				[Project key]
				  ,[Project number]
				  ,[Record key]
				  ,[DETAILS_Number]
				  ,[DETAILS_Revision no]
				  ,[DETAILS_Subject]
				  ,[DETAILS_Description]
				  ,[DETAILS_Track Items with Package]
				  ,[DETAILS_Status]
				  ,[DETAILS_Submittal Coordinator name]
				  ,[DETAILS_Notes]
				  ,[DETAILS_Official Reviewer]
				  ,[DETAILS_Instructions to Official Reviewer]
				  ,[DETAILS_Submission Due from Vendor]
				  ,[DETAILS_Date Submitted by Vendor]
				  ,[DETAILS_Send to Official Reviewer by]
				  ,[DETAILS_Date Submitted to Reviewer]
				  ,[DETAILS_Date Submitted to owner s Rep]
				  ,[DETAILS_Review period (days)]
				  ,[DETAILS_Response Due date]
				  ,[DETAILS_Offical Response date]
				  ,[DETAILS_Date Returned to Vendor]
			  ,SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0))
			  ,SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0))
			  ,@ProjAssocID
			  ,GETDATE()
			FROM Stage_ProjSubmittalPackageKahuaDetail3
			WHERE [Project number] = @KahuaProjNum
			end
		ELSE 
		begin

				print 'no match';
		INSERT INTO [audit].Fact_ProjSubmittalPackageKahuaDetail_Fail
				([Project_Key],
				[Project_Number],
				[Record_Key],
				[Details_Number],
				[Details_Revision_No],
				[Details_Subject],
				[Details_Description],
				[Details_Track_Items_With_Package],
				[Details_Status],
				[Details_Submittal_Coordinator_Name],
				[Details_Notes],
				[Details_Official_Reviewer],
				[Details_Instructions_to_Official_Reviewer],
				[Details_Submission_Due_From_Vendor],
				[Details_Date_Submitted_By_Vendor],
				[Details_Send_to_Official_Reviewer_By],
				[Details_Date_Submitted_to_Reviewer],
				[Details_Date_Submitted_to_Owners_Rep],
				[Details_Review_Period],
				[Details_Response_Due_Date],
				[Details_Offical_Response_Date],
				[Details_Date_Returned_to_Vendor],
				[Created_Date_Time],
				[Modified_Date_Time],
				[ProjAssocID],
				[Load_Date])

			SELECT
				[Project key]
				  ,[Project number]
				  ,[Record key]
				  ,[DETAILS_Number]
				  ,[DETAILS_Revision no]
				  ,[DETAILS_Subject]
				  ,[DETAILS_Description]
				  ,[DETAILS_Track Items with Package]
				  ,[DETAILS_Status]
				  ,[DETAILS_Submittal Coordinator name]
				  ,[DETAILS_Notes]
				  ,[DETAILS_Official Reviewer]
				  ,[DETAILS_Instructions to Official Reviewer]
				  ,[DETAILS_Submission Due from Vendor]
				  ,[DETAILS_Date Submitted by Vendor]
				  ,[DETAILS_Send to Official Reviewer by]
				  ,[DETAILS_Date Submitted to Reviewer]
				  ,[DETAILS_Date Submitted to owner s Rep]
				  ,[DETAILS_Review period (days)]
				  ,[DETAILS_Response Due date]
				  ,[DETAILS_Offical Response date]
				  ,[DETAILS_Date Returned to Vendor]
			  ,SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0))
			  ,SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0))
			  ,null
			  ,GETDATE()
			FROM dbo.Stage_ProjSubmittalPackageKahuaDetail3
			WHERE [Project number] = @KahuaProjNum
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
