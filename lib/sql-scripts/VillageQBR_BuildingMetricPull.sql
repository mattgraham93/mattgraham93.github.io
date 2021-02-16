select VillageName
	,sum(cast(ParkingStallCount as int)) Parking_Stall_Count
	,sum(cast(TotalGSF as int)) Total_GSF
	,sum(cast(TotalGFA as int)) Total_GFA
	,sum(cast(AmenityGFA as int)) Amenity_GFA
	,sum(cast(WorkplaceGFA as int)) Workplace_GFA
	,sum(cast(SeatCount as int)) Seatcount
from Fact_ProjMetbyCI a
	inner join Dim_ProjCheckIn b
		on a.CheckInID = b.CheckInID
	inner join Dim_Building c
		on b.BuildingID = c.BuildingID
where a.CheckInID like 'CI8%'
group by VillageName