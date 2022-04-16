DECLARE @month_name varchar(10);
  DECLARE @year int;
  DECLARE @date int;
  DECLARE @3years_period int;
  DECLARE @2years_period int;
  DECLARE @period int;
  Declare @Fiscal_year int;


BEGIN

---This code runs after every FY roll over happens
--INSERT INTO [dbo].[Fact_Build_Live_FcstTool_RawFcstData] 
--(Fiscal_period,
--Calendar_period,
--fiscal_period_month,
--Fiscal_year,
--Project_ID,
--Project_name,
--project_manger_name,
--Forecast_status)
SELECT dimdates.actual_fiscal_prd,
dimdates.FRCST_PRD,
dimdates.pwraps_frcst_prd,
dimdates.fiscal_year,
FRCST_PRJ.Project_ID,
FRCST_PRJ.Project_name,
FRCST_PRJ.project_manger_name,
FRCST_PRJ.Forecast_status
FROM
(
SELECT D.fiscal_period as actual_fiscal_prd,
FORECAST_PERIOD AS FRCST_PRD,forecast_Powerapps_period as pwraps_frcst_prd,
D.fiscal_year
  FROM Dim_Build_FcstToolDisplay_DateFields D
  WHERE D.fiscal_year = CONCAT('FY',(SUBSTRING(CAST(YEAR(GETDATE())+2 AS VARCHAR(4)),3,2)))
  and d.forecast_period <> concat(YEAR(GETDATE())+2,'01')
) dimdates,
(
select PROJECT_ID,Project_name, project_manger_name,Forecast_status,Fiscal_year
from [dbo].[Fact_Build_Live_FcstTool_RawFcstData]
WHERE Fiscal_year = CONCAT('FY',(SUBSTRING(CAST(YEAR(GETDATE())+2 AS VARCHAR(4)),3,2)))
AND Forecast_status = 'Y'
) FRCST_PRJ,
----Checking if there are any actuals  or not for Last period of previous forecast year
(
SELECT MAX(Period_date) AS LAST_ACTUALS_PERIOD
FROM [dbo].[Fact_Build_Manual_FcstTool_RawActuals]
) ACTL_PRD,
--------Checking if FY roll over happen or not
(
SELECT COUNT(DISTINCT Fiscal_period) AS PERIOD_COUNT
from [dbo].[Fact_Build_Live_FcstTool_RawFcstData]
WHERE Fiscal_year = CONCAT('FY',(SUBSTRING(CAST(YEAR(GETDATE())+2 AS VARCHAR(4)),3,2)))
AND Forecast_status = 'Y'
) PRD_CNT
WHERE FRCST_PRJ.Fiscal_year = DIMDATES.fiscal_year
AND LAST_ACTUALS_PERIOD = CONCAT(YEAR(GETDATE()),'12')
AND PRD_CNT.PERIOD_COUNT = 1 
;

---This code runs after every FY roll over happens

INSERT INTO Fact_Build_Live_FcstTool_RawFcstData 
(Fiscal_period,
Calendar_period,
fiscal_period_month,
Fiscal_year,
Project_ID,
Project_name,
project_manger_name,
Forecast_status)
SELECT  dimdates.actual_fiscal_prd,
dimdates.FRCST_PRD,
dimdates.pwraps_frcst_prd,
dimdates.fiscal_year,
FRCST_PRJ.Project_ID,
FRCST_PRJ.Project_name,
FRCST_PRJ.project_manger_name,
FRCST_PRJ.Forecast_status
FROM
(
SELECT D.fiscal_period as actual_fiscal_prd,
FORECAST_PERIOD AS FRCST_PRD,forecast_Powerapps_period as pwraps_frcst_prd,
D.fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] D
  WHERE D.fiscal_year = CONCAT('FY',(SUBSTRING(CAST(YEAR(GETDATE())+10 AS VARCHAR(4)),3,2)))
  and d.forecast_period = concat(YEAR(GETDATE())+10,'01')
) dimdates,
(
select DISTINCT PROJECT_ID,Project_name, project_manger_name,Forecast_status
from Fact_Build_Live_FcstTool_RawFcstData
WHERE Forecast_status = 'Y'
) FRCST_PRJ,
----Checking if there are any actuals  or not for Last period of previous forecast year
(
SELECT MAX(Period_date) AS LAST_ACTUALS_PERIOD
FROM [dbo].[Fact_Build_Manual_FcstTool_RawActuals]
) ACTL_PRD,
--------Checking if FY roll over happen or not
(
SELECT COUNT(DISTINCT Fiscal_period) AS PERIOD_COUNT
from Fact_Build_Live_FcstTool_RawFcstData
WHERE Fiscal_year = CONCAT('FY',(SUBSTRING(CAST(YEAR(GETDATE())+10 AS VARCHAR(4)),3,2)))
AND Forecast_status = 'Y'
) PRD_CNT
WHERE LAST_ACTUALS_PERIOD = CONCAT(YEAR(GETDATE()),'12')
AND PRD_CNT.PERIOD_COUNT <> 1 
;

--Update the manager name if the manager name changes for project insight projects
update b
set project_manger_name=a.CBRE_Project__Manager_Users_Contacts_Full_Name
from
[dbo].[Fact_CPS_PI_Project_Information] a
,[dbo].[Fact_Build_Live_FcstTool_RawFcstData] b
where cast(a.Project__Insight__Project__ID as varchar(100)) =b.Project_id
and (a.CBRE_Project__Manager_Users_Contacts_Full_Name <> b.project_manger_name
or b.project_manger_name is null)

--Update the manager name if the manager name changed for IW projects

update b
set project_manger_name=a.[CBRE Project Manager]
from
[dbo].[Fact_Build_IW_ProjectList] a
,[dbo].[Fact_Build_Live_FcstTool_RawFcstData] b
where a.[Project ID] =b.Project_id
and (a.[In PI] <>'Yes' or a.[In PI] is null)
and a.[Project ID] is not null
and a.[CBRE Project Manager]<> b.project_manger_name

--Update the Project Name if the project name changes for project insight changes

update b
set Project_name=a.Name
from
[dbo].[Fact_CPS_PI_Project_Information] a
,[dbo].[Fact_Build_Live_FcstTool_RawFcstData] b
where cast(a.Project__Insight__Project__ID as varchar(100)) =b.Project_id
and a.name <> b.Project_name


--Update the Project Name if the project name changes for IW Projects

update b
set Project_name=a.[Project Name]
from
dbo.Fact_Build_IW_ProjectList a
,[dbo].[Fact_Build_Live_FcstTool_RawFcstData] b
where a.[Project ID] =b.Project_id
and (a.[In PI] <>'Yes' or a.[In PI] is null)
and a.[Project ID] is not null
and a.[Project Name] <> b.Project_name

--update the forecast status for PI projects which are completed

update [dbo].[Fact_Build_Live_FcstTool_RawFcstData] 
set Forecast_status ='N'
WHERE project_id  in(select distinct CAST(a.Project__Insight__Project__ID AS varchar(100))
from [dbo].[Fact_CPS_PI_Project_Information] a
WHERE a.Project_Status in ('Complete','Cancelled'))
AND Forecast_status ='Y'

--update the forecast status for IW projects which are completed

update [dbo].[Fact_Build_Live_FcstTool_RawFcstData] 
set Forecast_status ='N'
WHERE project_id  in(select distinct a.[Project ID]
from dbo.Fact_Build_IW_ProjectList  a
WHERE a.[Project Status] in ('Complete','Cancelled'))
AND Forecast_status ='Y'

--find any new projects if yes insert the new projects

INSERT INTO [dbo].[Fact_Build_Live_FcstTool_RawFcstData] 
(Fiscal_period,Calendar_period,fiscal_period_month,Fiscal_year,Project_ID,Project_name,project_manger_name,Forecast_status)
SELECT 
actual_fiscal_prd,
FRCST_PRD,
pwraps_frcst_prd,
fiscal_year,
id, 
project_name,
manager_name,
'Y'
FROM
(  
  SELECT fiscal_period as actual_fiscal_prd,FORECAST_PERIOD AS FRCST_PRD,forecast_Powerapps_period as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT fiscal_year 
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6)
)
UNION
  SELECT fiscal_period as actual_fiscal_prd,FORECAST_PERIOD AS FRCST_PRD,forecast_Powerapps_period as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+1 ) 
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6)
)
UNION 
    SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+2 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  
  UNION 
    SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+3 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  UNION 
     SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+4 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  union
    SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+5 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  union
    SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+6 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  union
     SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+7 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  union
     SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+8 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
  union
    SELECT start_period AS actual_fiscal_prd,Min(FORECAST_PERIOD) AS FRCST_PRD,concat(fiscal_year,'-Jul') as pwraps_frcst_prd,fiscal_year
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields]
  WHERE fiscal_year = (
  SELECT CONCAT('FY',CAST(SUBSTRING(fiscal_year,3,2) AS INT)+9 )
  FROM [dbo].[Dim_Build_FcstToolDisplay_DateFields] 
  WHERE fiscal_period =  LEFT(CONVERT(varchar, GetDate(),112),6))
  group by fiscal_year,start_period
    )DRIVER, (select DISTINCT cast( Project__Insight__Project__ID as varchar(100)) as id,name as project_name,CBRE_Project__Manager_Users_Contacts_Full_Name  as manager_name
from [dbo].[Fact_CPS_PI_Project_Information]
where Project_Status not in('Cancelled','Complete')
and FM_Project__Descriptors_MS_Region IN ('PUGET SOUND','Puget Sound Integrator','PS Lifecycle Renewal','PS Lab Services','PS Project Delivery Business')
and ([FM_Project__Descriptors_Project__or__Placeholder__Type] <>'Non-Project' or [FM_Project__Descriptors_Project__or__Placeholder__Type] is null)
except select tab2.project_id, tab2.project_name,tab2.project_manger_name 
from  [dbo].[Fact_Build_Live_FcstTool_RawFcstData] tab2
union
Select Distinct [Project ID] as id,[Project Name] as project_name,[CBRE Project Manager] as manager_name from dbo.Fact_Build_IW_ProjectList
where [Project Status] not in ('Cancelled','Complete')
and [Project ID] is not null
and ([In PI] <>'Yes' or [In PI] is null)
except select tab3.project_id, tab3.project_name,tab3.project_manger_name 
from  [dbo].[Fact_Build_Live_FcstTool_RawFcstData] tab3
					 			 ) PRJCT
WHERE 1 = 1

ORDER BY id ASC, FRCST_PRD ASC;
 
 --update the forecast_Status to "N" for the previous periods
 -- commenting this code to allow PM's to enter the data after the month ends and
 --have to run this query when the finance team asked
--UPDATE dbo.[Fact_Build_FinForecastPmProj] 
--SET forecast_status ='N'
--WHERE actul_fiscal_period < LEFT(CONVERT(varchar, GetDate(),112),6)
--and forecast_status ='Y'

UPDATE [dbo].[Fact_Build_Live_FcstTool_RawFcstData] 
SET forecast_status ='N'
WHERE Calendar_period <=(Select max(period_date) from [dbo].[Fact_Build_Manual_FcstTool_RawActuals])
and Forecast_status ='Y'

--Insert previous FY data into Historical Table

INSERT INTO [dbo].[Fact_Build_FcstTool_Historical_RawFcstData]
           ([Project_ID]
           ,[Project_name]
           ,[project_manger_name]
           ,[Forecast_status]
           ,[Fiscal_period]
           ,[Calendar_period]
           ,[Fiscal_year]
           ,[fiscal_period_month]
           ,[NonSAP]
           ,[Building]
           ,[Networking]
           ,[AV]
           ,[Furniture]
           ,[Cafe]
           ,[TIA]
           ,[Contingency]
           ,[Shell_&_Core]
           ,[Land]
           ,[Other_Credits])
	 (select [Project_ID]
           ,[Project_name]
           ,[project_manger_name]
           ,[Forecast_status]
           ,[Fiscal_period]
           ,[Calendar_period]
           ,[Fiscal_year]
           ,[fiscal_period_month]
           ,[NonSAP]
           ,[Building]
           ,[Networking]
           ,[AV]
           ,[Furniture]
           ,[Cafe]
           ,[TIA]
           ,[Contingency]
           ,[Shell_&_Core]
           ,[Land]
           ,[Other_Credits] from [dbo].[Fact_Build_Live_FcstTool_RawFcstData]
		   where forecast_Status ='N'
		   AND fiscal_period <  LEFT(CONVERT(varchar, GetDate(),112),6) 
		   )

---Delete Previous FY data from the main table

delete from [dbo].[Fact_Build_Live_FcstTool_RawFcstData]
 where forecast_Status ='N'
AND fiscal_period <  LEFT(CONVERT(varchar, GetDate(),112),6) 
