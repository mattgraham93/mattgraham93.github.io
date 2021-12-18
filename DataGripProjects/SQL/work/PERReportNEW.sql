/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Project ID]
      ,[SAP Number]
      ,[Project Name]
      ,[Building Name]
      ,[Project Status]
      ,[CBRE Project Manager]
      ,[RE&F Dev Manager]
      ,[Capital or Expense]
      ,[CC/IO]
      ,[Funding Owner]
      ,[Funding Type]
      ,[Construction Complete DtC/O]
      ,[Current Total PM Estimate]
      ,[GC Company Name]
      ,[Design Firm]
      ,[Total Gross PER]
      ,[Current PER Amount]
      ,[Current Approved PER]
      ,[PER Report Comments]
      ,[PER Routing Iteration]
      ,[PER Status]
      ,[Capital Council CE#]
      ,[Prior FYs Actuals]
      ,[Budget Amount]
      ,[Approved PER]
      ,[Start of Construction]
      ,[Start of Design]
      ,[Client Approved Construction Complete]
      ,[PER Prefunding Submitted]
      ,[PER Prefunding Approved]
      ,[PER Submitted]
      ,[PER Approved]
      ,[PR Submitted]
      ,[PR Approved]
      ,[CB Region/Portfolio]
      ,[Site Ownership Type]
      ,[Program]
	  ,[Capital Council CE#]
  FROM [dbo].[VW_FullProjectList] fpl
 
  left join Fact_CPS_PI_Project_Information pii
	on fpl.[Project ID] = cast(pii.Project__Insight__Project__ID as nvarchar)
    where 
	[Project Status] not in ('Closeout', 'Cancelled', 'Complete', 'Future')
	and
	(
		([Funding Owner] like 'RE&F' and cast([Current Total PM Estimate] as int) >= 250000)
		or
		([Funding Owner] like 'Client' and cast([Current Total PM Estimate] as int) >= 1000000)
		or
		([CC/IO] = 1708181 and cast([Current Total PM Estimate] as int) >= 500000) -- always RE&F and > 250k, if that IO, then don't show up
		--or
		-- added from excel
		--([CC/IO] = 70310 and cast([Current Total PM Estimate] as int) >= 250000)
	)
	and Program not in ('Redwest South','Development','IW','LCR Facilities (Exp)')

	-- added from previous knowledge, do we need this?
	-- and (pii.FM_Project__Descriptors_MS_Region like '%PS%' or pii.FM_Project__Descriptors_MS_Region like '%Puget%')

	-- added from excel, originally coined "LCR Expense"

	-- added from excel
	--and [Construction Complete DtC/O] <= DATEADD(year,5,getdate())
	-- added from excel, thinking this needs to only exist in client view so all projects in these parameters show up
	--and ([PER Submitted] < DATEADD(month,6,GETDATE()) or [PR Submitted] < DATEADD(month,6,GETDATE()))



	--select FM_Project__Descriptors_Current__FY_PM_Estimate
	--from Fact_CPS_PI_Project_Information