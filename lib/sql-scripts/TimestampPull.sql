/****** Script for SelectTopNRows command from SSMS  ******/
SELECT Fact_EACbyCI.CheckInID, Dim_Building.VillageCode,
	CONCAT(
		CASE WHEN CostConstructionCode not like '' 
			THEN
			CONCAT(CostConstructionCode,'.', Dim_Building.VillageCode, '.')
			END,
		CASE 
			WHEN Fact_EACbyCI.WBSAccountingCode not like '' 
			THEN
			CONCAT(Fact_EACbyCI.WBSAccountingCode, '.', Dim_Building.BuildingCode, '.')
		END,
		CASE
			WHEN Fact_EACbyCI.WBSProjectCode not like ''
			THEN
			Fact_EACbyCI.WBSProjectCode
		END) as WBSObject,
		Fact_EACbyCI.AssetClass,
		--Dim_FinWBSCode.WBSAccountingName,
		--Dim_FinWBSCode.WBSProjectName,
		--Dim_FinActivityCode.ActivityName,
		--Dim_FinActivityCode.SubActivityName,
		Dim_Building.VillageName,
		Dim_Building.BuildingName,
		Fact_EACbyCI.Budget,
		Fact_EACbyCI.EffectiveBaseline,
		Fact_EACbyCI.EstimateatCompletion
	FROM [RedmondCR].[dbo].[Fact_EACbyCI]
		INNER JOIN Dim_ProjCheckIn
			on Fact_EACbyCI.CheckInID = Dim_ProjCheckIn.CheckInID
		inner join Dim_Building
			on Dim_ProjCheckIn.BuildingID = Dim_Building.BuildingID
		--left outer join Dim_FinWBSCode
		--	on Fact_EACbyCI.WBSProjectCode = Dim_FinWBSCode.WBSProjectCode
		--left outer join Dim_FinActivityCode
		--	on Fact_EACbyCI.ActivityCode = Dim_FinActivityCode.ActivityCode
where Fact_EACbyCI.CheckInID like 'CI7%' AND Fact_EACbyCI.CheckInID not like ''


--select *
--from Fact_EACbyCI
--where WBSProjectCode like '9.%'

--update Fact_EACbyCI
--set WBSProjectCode = replace(WBSProjectCode, '9.', '09.')
--where WBSProjectCode like '9.%'

