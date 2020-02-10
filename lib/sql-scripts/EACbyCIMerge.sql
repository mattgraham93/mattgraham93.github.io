--select bk.[WBS Object], value
--from vw_TSTP_BCTBgt as bk
--	cross apply string_split([WBS Object], '.');

with C as (
	select vw_TSTP_BCTBgt.[WBS Object], 
	value, 
	ROW_NUMBER() OVER(PARTITION BY vw_TSTP_BCTBgt.[WBS Object] ORDER BY (SELECT NULL)) as rn, 
	vw_TSTP_BCTBgt.Activity, 
	vw_TSTP_BCTBgt.Sub_Activity,
	CheckInID
	from vw_TSTP_BCTBgt
		cross apply string_split(vw_TSTP_BCTBgt.[WBS Object], '.') as lk
	)
select [WBS Object], Activity, Sub_Activity, [1] as CostConstruction, [2] as Village, CONCAT([3], '.', [4]) as WBSAccounting, concat([6], '.', [7]) as WBSProject, CheckInID
from C
		pivot (
			max(value)
			for rn in ([1],[2],[3],[4],[5],[6],[7])
			)
			as pvt
where pvt.[1] is null
order by CheckInID
	--left outer join Dim_FinActivityCode
	--	on pvt.Sub_Activity = Dim_FinActivityCode.SubActivityName