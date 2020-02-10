alter procedure spVW_TSTP_BCTBgt_UpdateEACbyCI
as
begin

/** Declare and set variables **/
DECLARE @CheckInOrder nvarchar(20)
DECLARE @LatestViewCheckInOrder nvarchar(20)
DECLARE @EACOrder nvarchar(20)

-- set CheckInOrder as max order number where the project check-in date is not null
set @CheckInOrder = 
	(select
		MAX(CheckInOrder)
	from Dim_ProjCheckIn
	where Dim_ProjCheckIn.CheckInDate is not null
	)

-- set LatestViewCheckInOrder as the max substring value; this will be used to validate which check-in order is active
set @LatestViewCheckInOrder =
	(select 
		MAX(SUBSTRING(CheckInID,3,1))
	from vw_TSTP_BCTBgt)

set @EACOrder =
	(select
		ISNULL(MAX(SUBSTRING(CheckInID,3,1)),0)
	from TEST_TSTPPush)

/** Copies tabularized WBS Object line items from vw_TSTP_BCTBgt where the latest check-in order is matched from latest check-in order in Dim_ProjCheckIn**/
insert into Fact_EACbyCI(
	CostConstructionCode
	,WBSAccountingCode
	,WBSProjectCode
	,ActivityCode
	,AssetClass
	,Budget
	,EffectiveBaseline
	,EstimateatCompletion
	,CheckInID
	,SubActivityCode)
select
	CAST(SUBSTRING([WBS Object],1,2) as varchar(250)) as CostConstructionCode
	,CAST(SUBSTRING([WBS Object],10,6) as varchar(250)) as WBSAccountingCode
	,CAST(SUBSTRING([WBS Object],22,6) as varchar(250)) as WBSProjectCode
	,CAST(Dim_FinActivityCode.ActivityCode as varchar(50)) as ActivityCode
	,CAST([Asset Class] as varchar(250)) as AssetClass
	,CAST(Budget as decimal(20,2)) as Budget
	,CAST(Effective_Baseline as decimal(20,2)) as EffectiveBaseline
	,CAST(Estimate_at_Completion as decimal(20,2)) as EstimateatCompletion
	,CAST(CheckInID as nvarchar(20)) as CheckInID
	,CAST(Dim_FinActivityCode.SubActivityCode as varchar(250)) as SubActivityCode
from vw_TSTP_BCTBgt as C

/** Joining only lines from C with lines that exist in Dim_FinActivityCode by a unique combination of WBSProjectCode and SubActivityName.
	Allows and inserts null values when applicable.
	Join is used to return SubActivityCode and ActivityCode to C. **/

left outer join Dim_FinActivityCode
	on CAST(substring(C.[WBS Object],22,6) as varchar(100)) = Dim_FinActivityCode.WBSProjectCode AND C.Sub_Activity = Dim_FinActivityCode.SubActivityName
where @LatestViewCheckInOrder = @CheckInOrder AND @EACOrder < @CheckInOrder

end