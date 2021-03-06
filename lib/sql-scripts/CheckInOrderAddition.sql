
create table #NewCheckIns (
	CheckInID nvarchar(20),
	BuildingID varchar(50),
	CheckInDate date null,
	CheckInOrder int null,
	ReviewFlag bit null
)

declare @CheckInOrder int
set @CheckInOrder = ((select MAX(CheckInOrder) from Dim_ProjCheckIn) + 1)

insert into #NewCheckIns (
	BuildingID
	, CheckInDate
	, CheckInOrder
	, CheckInID
) select distinct 
	BuildingID
	, GETDATE()
	, @CheckInOrder
	, CONCAT('CI', @CheckInOrder,'.', LEFT(BuildingID,1), '.', RIGHT(BuildingID,1))
from Dim_ProjCheckIn

insert into Dim_ProjCheckIn
select * from #NewCheckIns

drop table #NewCheckIns




INSERT INTO
	 Dim_ProjCheckin  ----this will select data into the DIM table
SELECT DISTINCT
	f.CheckInID --Inserts the distinct Checkin Ids from the Fact table
	,(CASE
		WHEN f.CheckInID LIKE '%.0.1' THEN '0.0001'
		WHEN f.CheckInID LIKE '%.0.2' THEN '0.0002'
		WHEN f.CheckInID LIKE '%.0.3' THEN '0.0003'
		WHEN f.CheckInID LIKE '%.0.4' THEN '0.0004'
		WHEN f.CheckInID LIKE '%.0.5' THEN '0.0005'
		WHEN f.CheckInID LIKE '%.1.1' THEN '1.0001'
		WHEN f.CheckInID LIKE '%.1.3' THEN '1.0003'
		WHEN f.CheckInID LIKE '%.2.1' THEN '2.0001'
		WHEN f.CheckInID LIKE '%.2.2' THEN '2.0002'
		WHEN f.CheckInID LIKE '%.2.3' THEN '2.0003'
		WHEN f.CheckInID LIKE '%.2.4' THEN '2.0004'
		WHEN f.CheckInID LIKE '%.2.5' THEN '2.0005'
		WHEN f.CheckInID LIKE '%.3.2' THEN '3.0002'
		WHEN f.CheckInID LIKE '%.3.3' THEN '3.0003'
		WHEN f.CheckInID LIKE '%.3.4' THEN '3.0004'
		WHEN f.CheckInID LIKE '%.3.5' THEN '3.0005'
		WHEN f.CheckInID LIKE '%.3.6' THEN '3.0006'
		WHEN f.CheckInID LIKE '%.4.1' THEN '4.0001'
		WHEN f.CheckInID LIKE '%.5.1' THEN '5.0001'
		ELSE 'ERROR'
		END) 
	AS BuildingID  -- This CASE statement looks at the new CheckInID from the Fact table and then creates the appropriate BuildingID in the Dim table
	,CONVERT(VARCHAR(10),t.[Timestamp]) AS CheckInDate --This takes the TimeStamp Date from the vw_TSTP_BCTBgt view and assigns it as the CheckInDate in the Dim table
	,SUBSTRING(f.CheckInID, 3, 1) AS CheckInOrder -- This pulls just the checkin number portion of the CheckInID field and assigns it to the Dim table as the CheckInOrder
FROM
	Fact_ProjMetbyCI f
INNER JOIN
	vw_TSTP_BCTBgt t ON t.CheckInID = f.CheckInID -- This allows us to pull in the Timestamp data from the Timestamp view
		
WHERE NOT EXISTS --This is telling SQL to only pull CheckInID's which are present in the Fact table, but not present in the Dim table (because each check-in will involve us manually adding the new checkin id's to the fact table via updating an excel workbook)
	(
	SELECT 
		*
	 FROM 
		Dim_ProjCheckin d
	WHERE
		d.CheckInID = f.CheckInID
	)
END
