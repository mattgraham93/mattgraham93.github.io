with c as (
select cp.CapexProjectId 'ProjectID', 
cp.RegionName 'RegionName',
cp.SAPPSProjectID 'SAPPSProjectID', 
cp.ProjectName 'ProjectName',
cp.CapitalCouncilStatus 'CapitalCouncilStatus',
	cast(
	case 
	when substring(cp.CCStatusDate,1,3)= 'Jan'
		then concat(cast('01' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Feb'
		then concat(cast('02' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Mar'
		then concat(cast('03' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Apr'
		then concat(cast('04' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'May'
		then concat(cast('05' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Jun'
		then concat(cast('06' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Jul'
		then concat(cast('07' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Aug'
		then concat(cast('08' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Sep'
		then concat(cast('09' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Oct'
		then concat(cast('10' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Nov'
		then concat(cast('11' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	when substring(cp.CCStatusDate,1,3)= 'Dec'
		then concat(cast('12' as varchar),'/',substring(cp.CCStatusDate,5,2),'/',substring(cp.CCStatusDate,9,4))
	end 
	as date
	) 'SubmissionDate',
cp.CCApprovalSerialNumberCode 'CCApprovalSerialNumberCode',
cp.CCApprovalAmount 'Amount' 
from [dbo].[Fact_Build_CapexPerspective] cp 
	left join  Fact_Build_CapitalCouncilPending p 
	on cast(p.ProjectID as varchar)= cp.CapexProjectId 
WHERE cp.[RegionName]='Puget Sound' AND cp.[CapitalCouncilStatus]='Approved' AND cp.[CurrencyType]='Constant Dollar' AND cp.[SpendClass]='Capex'
union all

SELECT cast([ProjectID] as varchar)
      ,[RegionName]
      ,[SAPPSProjectID]
      ,[ProjectName]
      ,[CapitalCouncilStatus]
      ,[SubmissionDate] 
      ,[CCApprovalSerialNumberCode]
      ,[Amount]
   FROM [dbo].[Fact_Build_CapitalCouncilPending]
 where cast([ProjectID]as varchar) not in (select CapexProjectId from [dbo].[Fact_Build_CapexPerspective])
 )
 select distinct [ProjectID],
	[RegionName]
      ,[SAPPSProjectID]
      ,[ProjectName]
      ,[CapitalCouncilStatus]
      ,[SubmissionDate] 
      ,[CCApprovalSerialNumberCode]
      ,[Amount] from c