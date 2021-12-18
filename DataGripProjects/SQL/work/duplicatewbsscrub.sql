with dups as (
		select count(*) 'WBS Count',
		case when WBSAccountingCode not in('10','20') and WBSProjectCode is not null then
			concat(ConstructionCostCode,'.',WBSAccountingCode,'.',WBSProjectCode)
		when WBSAccountingCode not in('10','20') and WBSProjectCode is null then
			concat(ConstructionCostCode,'.',WBSAccountingCode)
		else
			concat(Substring(ConstructionCostCode,2,1),'.',SUBSTRING(WBSAccountingCode,1,1))
	END 'Full WBS Code',
	WBSCodeType
	from Test_Build_FinWBSCode
	where WBSCodeStatus like 'Active'
	group by WBSProjectCode, WBSAccountingCode, ConstructionCostCode, WBSCodeType
	),
dupind as (
	select *,
		case when [WBS Count] > 1
			then 'dupe'
		else 'not'
	end 'dupe flag'
	from dups
	where [WBS Count] > 1
	)
select * from
Test_Build_FinWBSCode twbs
	right join dupind dupe
		on dupe.[Full WBS Code] =  (case when twbs.WBSAccountingCode not in('10','20') and twbs.WBSProjectCode is not null then
			concat(twbs.ConstructionCostCode,'.',twbs.WBSAccountingCode,'.',twbs.WBSProjectCode)
		when twbs.WBSAccountingCode not in('10','20') and twbs.WBSProjectCode is null then
			concat(twbs.ConstructionCostCode,'.',twbs.WBSAccountingCode)
		else
			concat(Substring(twbs.ConstructionCostCode,2,1),'.',SUBSTRING(twbs.WBSAccountingCode,1,1))
		end)

--select * 
--from dupind


select *
from Test_Build_FinWBSCode
where ConstructionCostCode like '04' and WBSAccountingCode like '20'



--Test_Build_FinWBSCode twbs
--	right join dupind dupe
--		on dupe.[Full WBS Code] =  (case when twbs.WBSAccountingCode not in('10','20') and twbs.WBSProjectCode is not null then
--			concat(twbs.ConstructionCostCode,'.',twbs.WBSAccountingCode,'.',twbs.WBSProjectCode)
--		when twbs.WBSAccountingCode not in('10','20') and twbs.WBSProjectCode is null then
--			concat(twbs.ConstructionCostCode,'.',twbs.WBSAccountingCode)
--		else
--			concat(Substring(twbs.ConstructionCostCode,2,1),'.',SUBSTRING(twbs.WBSAccountingCode,1,1))
--		end)



with cte as (
	select *,
		rn = row_number()over(partition by c)
	from Test_Build_FinWBSCode
)
delete from cte where rn > 1