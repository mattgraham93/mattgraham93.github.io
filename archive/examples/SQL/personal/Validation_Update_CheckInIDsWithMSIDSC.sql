/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [CheckInID]
      ,pci.[BuildingID]
      ,[CheckInDate]
      ,[CheckInOrder]
      ,[OfficialReview]
      ,CONCAT(pms.MilestoneIDSC,'.', LEFT(pci.BuildingID,1), '.', RIGHT(pci.BuildingID,1))
		, case when pms.MilestoneIDTI is null
		then null else
		CONCAT(pms.MilestoneIDTI,'.', LEFT(pci.BuildingID,1), '.', RIGHT(pci.BuildingID,1)) end
  FROM [RedmondCR].[dbo].[Dim_ProjCheckIn] pci
	inner join Fact_ProjMetSummary pms
		on pci.BuildingID = pms.BuildingID
where CheckInOrder = 9

update Dim_ProjCheckIn
set MilestoneIDSC = concat(pms.MilestoneIDSC, '.', LEFT(pci.BuildingID,1), '.', RIGHT(pci.BuildingID,1))
from Dim_ProjCheckIn pci
	inner join Fact_ProjMetSummary pms
		on pci.BuildingID = pms.BuildingID
where pci.BuildingID = pms.BuildingID and CheckInOrder = 9

select * from Dim_ProjCheckIn
where CheckInOrder = 9