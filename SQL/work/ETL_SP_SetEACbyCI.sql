

-- copy rows from vw_TSTP_BCGBgt to TEST_TSTPPull
insert into Fact_EACbyCI(CostConstructionCode, WBSAccountingCode, WBSProjectCode, ActivityCode, AssetClass, Budget, EffectiveBaseline, EstimateatCompletion, CheckInID, SubActivityCode)
select
	CAST(SUBSTRING([WBS Object],1,2) as varchar(250)) as CostConstructionCode,
	CAST(SUBSTRING([WBS Object],10,6) as varchar(250)) as WBSAccountingCode,
	CAST(SUBSTRING([WBS Object],22,6) as varchar(250)) as WBSProjectCode,
	CAST(Dim_FinActivityCode.ActivityCode as varchar(50)) as ActivityCode,
	CAST([Asset Class] as varchar(250)) as AssetClass,
	CAST(Budget as decimal(20,2)) as Budget,
	CAST(Effective_Baseline as decimal(20,2)) as EffectiveBaseline,
	CAST(Estimate_at_Completion as decimal(20,2)) as EstimateatCompletion,
	CAST(CheckInID as nvarchar(20)) as CheckInID,
	CAST(Dim_FinActivityCode.SubActivityCode as varchar(250)) as SubActivityCode
from vw_TSTP_BCTBgt as C
left outer join Dim_FinActivityCode
	on CAST(substring(C.[WBS Object],22,6) as varchar(100)) = Dim_FinActivityCode.WBSProjectCode AND C.Sub_Activity = Dim_FinActivityCode.SubActivityName
where C.CheckInID like 'CI7.%'
