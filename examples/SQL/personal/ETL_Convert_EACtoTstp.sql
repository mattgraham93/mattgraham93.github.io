--select BCT_Bdgt_ID, 
--	Check_In_ID,
--	CAST(SUBSTRING(Com_WBS_Project_Code,1,2) as varchar(250)) as CostConstructionCode,
--	CAST(SUBSTRING(Com_WBS_Project_Code,10,6) as varchar(250)) as WBSAccountingCode,
--	CAST(SUBSTRING(Com_WBS_Project_Code,22,6) as varchar(250)) as WBSProjectCode
--	--CAST(a.SubActivityCode as nvarchar(255))
--from Fact_FinTstpBCTBdgt b
----	left join Dim_FinActivityCode a
----		on b.Sub_Activity_Name = a.SubActivityName
----where b.Sub_Activity_Name = a.SubActivityName
--order by 2 asc

insert into Fact_FinTstpBCTBdgt (
	Check_In_ID,
	Com_WBS_Project_Code,
	Estimate_at_Completion,
	Effective_Baseline,
	Budget,
	Asset_Class,
	Timestamp
)
select case when a.CheckInID like '' then 'NO ID'  
		else a.CheckInID
		end
	,case 
		when CostConstructionCode like '' then CONCAT(VillageCode, '.', BuildingCode)
		when CostConstructionCode not like '' then 
		CONCAT(CostConstructionCode,
			case when a.WBSAccountingCode is not null or a.WBSAccountingCode not like '' then + '.' + VillageCode + '.' + a.WBSAccountingCode + '.' + BuildingCode end,
			case when a.WBSProjectCode is not null and a.WBSProjectCode not like '' then + '.' + a.WBSProjectCode end
			) end Com_WBS_Project_Code
	,EstimateatCompletion
	, a.EffectiveBaseline
	, a.Budget
	,AssetClass
	,cast(b.CheckInDate as nvarchar(255))
from Fact_EACbyCI a
	left join Dim_ProjCheckIn b
		on b.CheckInID = case 
			when RIGHT(a.CheckInID, 1) like '0' and RIGHT(a.CheckInID, 3) like '3.0' then stuff(a.CheckInID, 7, 7, '2') 
			when RIGHT(a.CheckInID, 1) like '0' and SUBSTRING(a.CheckInID, 4, 4) not like '3' then stuff(a.CheckInID, 7, 7, '1') 
			else a.CheckInID 
		end
	left join Dim_Building c
		on b.BuildingID = c.BuildingID
	left join Dim_FinActivityCode d
		on a.WBSProjectCode = d.WBSProjectCode and a.WBSAccountingCode = d.WBSAccountingCode and a.SubActivityCode = d.SubActivityCode
where CAST(SUBSTRING(a.CheckInID, 3, 1) AS INT) < 5 and a.CheckInID not like ''
--group by a.CheckInID, CostConstructionCode, a.WBSAccountingCode, a.WBSProjectCode--, a.ActivityCode --, VillageCode, BuildingCode
order by 1 asc