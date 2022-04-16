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
CREATE PROCEDURE Load_Fact_ProjMeetingKahuaDetail
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
			INSERT INTO Fact_ProjMeetingKahuaDetail
				(
				 [Kahua_Proj_Num]
				  ,[Meeting_Key]
				  ,[Details_Subject]
				  ,[Details_Type]
				  ,[Details_Start_Date]
				  ,[Details_End_Date]
				  ,[Details_Start_Time]
				  ,[Details_End_Time]
				  ,[Details_Prepared_By_Name]
				  ,[Details_Meeting_Notes]
				  ,[Created_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Load_Date]
				  ,[Proj_Assoc_ID]
				)
			SELECT
				[Project Niumber]
				  ,[Meeting Key]
				  ,[DETAILS_Subject]
				  ,[DETAILS_Type]
				  ,[DETAILS_Start Date]
				  ,[DETAILS_End Date]
				  ,[DETAILS_Start Time]
				  ,[DETAILS_End Time]
				  ,[DETAILS_Prepared By NAME]
				  ,[DETAILS_Meeting Notes]
			  ,SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0))
			  ,SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0))
			  ,GETDATE()
			  ,@ProjAssocID

			FROM Stage_ProjMeetingKahuaDetail2
			WHERE [Project Niumber] = @KahuaProjNum
			end
		ELSE 
		begin

				print 'no match';
		INSERT INTO audit.Fact_ProjMeetingKahuaDetail_Fail
				(
				[Kahua_Proj_Num]
				  ,[Meeting_Key]
				  ,[Details_Subject]
				  ,[Details_Type]
				  ,[Details_Start_Date]
				  ,[Details_End_Date]
				  ,[Details_Start_Time]
				  ,[Details_End_Time]
				  ,[Details_Prepared_By_Name]
				  ,[Details_Meeting_Notes]
				  ,[Created_Date_Time]
				  ,[Modified_Date_Time]
				  ,[Proj_Assoc_ID]
				  ,[Load_Date]
				  )
			SELECT
				[Project Niumber]
				  ,null
				  ,[DETAILS_Subject]
				  ,[DETAILS_Type]
				  ,[DETAILS_Start Date]
				  ,[DETAILS_End Date]
				  ,[DETAILS_Start Time]
				  ,[DETAILS_End Time]
				  ,[DETAILS_Prepared By NAME]
				  ,[DETAILS_Meeting Notes]
			  ,cast(SUBSTRING([CreatedDateTime], 0, CHARINDEX('U', [CreatedDateTime], 0)) as datetime)
			  ,cast(SUBSTRING([ModifiedDateTime], 0, CHARINDEX('U', [ModifiedDateTime], 0)) as datetime)
			  ,null
			  ,GETDATE()
			FROM dbo.Stage_ProjMeetingKahuaDetail2
			WHERE [Project Niumber] = @KahuaProjNum
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
