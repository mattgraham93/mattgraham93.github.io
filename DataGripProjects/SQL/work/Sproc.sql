Declare  @KahuaProjNum int,
		@ProjAssocID int;

BEGIN TRY
	BEGIN TRAN
	Declare ProjIssuesKahuaDetail CURSOR
		FOR SELECT
				[Project Key]
			FROM dbo.Stage_ProjIssuesKahuaDetail
		

	OPEN ProjIssuesKahuaLocation;

			FETCH NEXT FROM ProjIssuesKahuaDetail INTO 
		@KahuaProjNum;
		print @KahuaProjNum;
			print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));
	WHILE @@FETCH_STATUS = 0
		BEGIN

			FETCH NEXT FROM ProjIssuesKahuaDetail INTO 
		@KahuaProjNum;
		--@ProjAssocID
		print 'in while loop:' + @KahuaProjNum;
		--print @ProjAssocID;

		SELECT @ProjAssocID = Proj_Assoc_ID 
		from dbo.Dim_ProjNumAssoc
		where @KahuaProjNum = Kahua_Bldg_Proj_No

		print 'projassocid ' + @ProjAssocID;

		print 'projnum: '+cast(@KahuaProjNum as nvarchar(5));

	print 'fetch pos: '+cast(@@fetch_status as nvarchar(5));


		IF (@KahuaProjNum <> NULL AND @KahuaProjNum > 0 AND @ProjAssocID <> NULL AND @ProjAssocID > 0 )
		begin
			print 'not null';
INSERT INTO [dbo].[Fact_ProjIssuesKahuaDetail]
           ()

			SELECT 
			cast([Issue Key] as int)
			,cast(@KahuaProjNum as int)
			,cast([Location Key] as int)			  
			,cast(@ProjAssocID as int)
			,getdate()
		  FROM [dbo].[Stage_ProjIssuesKahuaLocation]


			end
		
		ELSE 
		begin
				print 'no match';

		INSERT INTO [Audit].Fact_ProjIssuesKahuaDetail_Fail
           ([Issue_Record_Key]
		   ,[Project_Key]
           ,[Kahua_Proj_Num]
           ,[Location_Key]
           ,[Proj_Assoc_ID]
		   ,[Load_Date])
			SELECT 
			cast([Issue Key] as int)
			,cast([Project Key] as int)
			,cast(@KahuaProjNum as int)
			  ,cast([Location Key] as int)
			  ,cast(@ProjAssocID as int)
			  ,getdate()
		  FROM [dbo].[Stage_ProjIssuesKahuaLocation]
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

	CLOSE ProjIssuesKahuaLocation;
 
	DEALLOCATE ProjIssuesKahuaLocation;