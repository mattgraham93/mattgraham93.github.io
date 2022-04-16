create table #ProjCheckIn (
	CheckInID nvarchar(20),
	BuildingID varchar(50),
	CheckInDate date null,
	CheckInOrder int null,
	OfficialReview bit null,
	MilestoneIDSC varchar(50) null,
	MilestoneIDTI varchar(50) null
)

-- load temp ProjCheckIn with current Dim_ProjCheckIn data and add MilestoneIDs for SC/TI
--insert into #ProjCheckIn (
--	BuildingID
--	, CheckInDate
--	, CheckInOrder
--	, CheckInID
--	, OfficialReview
--	, MilestoneIDSC
--	, MilestoneIDTI
--) select pci.BuildingID
--	, CheckInDate
--	, CheckInOrder
--	, CheckInID
--	, OfficialReview
--	, pci.MilestoneIDSC
--	, pci.MilestoneIDTI
--from  Dim_ProjCheckIn pci
--	inner join Dim_Building bldg
--		on pci.BuildingID = bldg.BuildingID
--	inner join Fact_ProjMetSummary pms
--		on bldg.BuildingID = pms.BuildingID


-- check and see what we're looking like
--select * from #ProjCheckIn

-- used for testing before getting to creating new ones
--drop table #NewCheckIns
--drop table #ProjCheckIn

-- FINAL QUERY

-- create new order and set it to be greater than the current maximum order
declare @CheckInOrder int
set @CheckInOrder = ((select MAX(CheckInOrder) from Dim_ProjCheckIn) + 1)
select @CheckInOrder

--  Insert new CheckInIDs and copy over PMS Milestones by adding the village and 
--  building end-codes with the newly created @CheckInOrder and concatenating the Milestones

insert into Dim_ProjCheckIn(
	BuildingID
	, CheckInDate
	, CheckInOrder
	, CheckInID
	, OfficialReview
	, MilestoneIDSC
	, MilestoneIDTI
) 
select distinct 
	pci.BuildingID
	, GETDATE()
	, @CheckInOrder
	, CONCAT('CI', @CheckInOrder,'.', LEFT(pci.BuildingID,1), '.', RIGHT(pci.BuildingID,1))
	, OfficialReview
	, CONCAT(pms.MilestoneIDSC,'.', LEFT(pci.BuildingID,1), '.', RIGHT(pci.BuildingID,1))
	, case when pms.MilestoneIDTI is null
		then null else
		CONCAT(pms.MilestoneIDTI,'.', LEFT(pci.BuildingID,1), '.', RIGHT(pci.BuildingID,1)) end
from Dim_ProjCheckIn pci
	inner join Dim_Building bldg
			on pci.BuildingID = bldg.BuildingID
	inner join Fact_ProjMetSummary pms
		on bldg.BuildingID = pms.BuildingID

--insert into #ProjCheckIn
--select * from #NewCheckIns

--drop table #NewCheckIns
--drop table #ProjCheckIn

select * from #ProjCheckIn

