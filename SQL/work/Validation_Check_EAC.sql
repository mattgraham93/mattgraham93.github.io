select SUM(Estimate_at_Completion) as EAC, SUM(Budget) as Budget  --, Village, VillageCode
from vw_TSTP_BCTBgt
where CheckInID like 'CI7.%' --AND [WBS Object] not like '%10.007%' --AND [Asset Class] like 'Contingencies'
--group by Village, VillageCode
--order by VillageCode




select SUM(EstimateatCompletion) as EAC, SUM(Budget) as Budget, VillageName, VillageCode
from Fact_EACbyCI
	inner join Dim_ProjCheckIn
		on Fact_EACbyCI.CheckInID = Dim_ProjCheckIn.CheckInID
	inner join Dim_Building
		on Dim_ProjCheckIn.BuildingID = Dim_Building.BuildingID
where Fact_EACbyCI.CheckInID like 'CI7.%' --AND WBSAccountingCode not like '10.007' --AND AssetClass like 'Contingencies' 
group by VillageName, VillageCode
order by VillageCode
