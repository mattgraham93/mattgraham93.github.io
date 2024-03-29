/****** Object:  StoredProcedure [dbo].[sp_GetAzureLoadDate]    Script Date: 7/7/2021 9:49:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[sp_GetAzureLoadDate] 
	@TableName varchar(250)
as
	declare @Schema varchar(50)
	declare @Query nvarchar(500)
	declare @LoadDate datetime

	set @Schema = 'dbo'

	set @Query = 'select max(AzureLoadDate) from ' + @Schema + '.' + @TableName

	declare @result table([AzureLoadDate] datetime);
	insert into @result
	exec ( @Query );

	set @LoadDate = (select * from @result)

	return convert(int, @LoadDate)




	create table [aud].[Build_ProjLinkUpload] (
		TableName varchar(250),
		TotalRows int,
		AzureLoadDate datetime,
		DateChecked datetime
	)

	insert into [aud].[Build_ProjLinkUpload]
	select * from dbo.Fact_Build_ProjLinkUploadAudit


