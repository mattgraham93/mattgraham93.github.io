
SELECT Dim_Building.BuildingName, TotalGSF, TotalGFA, AmenityGFA
  FROM [RedmondCR].[dbo].[Fact_ProjMetbyCI]
	inner join Dim_ProjCheckIn
	on Fact_ProjMetbyCI.CheckInID = Dim_ProjCheckIn.CheckInID
	inner join Dim_Building
	on Dim_ProjCheckIn.BuildingID = Dim_Building.BuildingID
where BuildingStatus like '%scope%' and Dim_ProjCheckIn.CheckInOrder = 6 and BuildingName <> 'Site'
group by BuildingName, TotalGSF, TotalGFA, AmenityGFA
order by AmenityGFA asc