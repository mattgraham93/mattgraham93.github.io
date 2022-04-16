--create view Build_PERReportDatePivot
--as
with DatePivot (MSPID, RoutingStatus, RoutingDate, RoutingRank)
as
	(select MSPID, RoutingStatus, 
		case
			when RoutingDate like '%1900%' or RoutingDate like '%1899%' then
				null
			else cast(RoutingDate as date)
			end as RoutingDate,
		case 
			when RoutingStatus like 'PERPrefundingSubmitted' then 1
			when RoutingStatus like 'PERPrefundingApproved' then 2
			when RoutingStatus like 'PERSubmitted' then 3
			when RoutingStatus like 'PERApproved' then 4
			when RoutingStatus like 'PRSubmitted' then 5
			when RoutingStatus like 'PRApproved' then 6
		end as RoutingRank
	from 
		(select MSProjectID MSPID, 
			cast(PERPrefundingSubmitted as nvarchar) PERPrefundingSubmitted, 
			cast(PERPrefundingApproved as nvarchar) PERPrefundingApproved, 
			cast(PERSubmitted as nvarchar) PERSubmitted, 
			cast(PERApproved as nvarchar) PERApproved, 
			cast(PRSubmitted as nvarchar) PRSubmitted, 
			cast(PRApproved as nvarchar) PRApproved
		from vw_Build_PERReport) p 
	unpivot
		(RoutingDate for RoutingStatus in 
			(PERPrefundingSubmitted, PERPrefundingApproved, PERSubmitted, PERApproved, PRSubmitted, PRApproved)
		) as unpvt
	)
select dp.MSPID, dp.RoutingStatus, dp.RoutingRank
	, lag(dp.RoutingDate, 1, null) over (partition by dp.MSPID order by dp.MSPID) as StartDate,
	dp.RoutingDate FinishDate
from DatePivot dp


--drop view Build_PERReportDatePivot