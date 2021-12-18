-- Projects by quarter
--select concat(d.Clientfiscalyear,'Q',d.Clientfiscalquarter) ClientFYQuarter, count(*) [ProjectsCreated]
--from Fact_CPS_PI_Project_Information i
--	left join Dim_Build_Date d
--		on cast(i.Created as date) = cast(d.SQLdate as date)
--where Clientfiscalyear in (2021, 2022)
--group by d.Clientfiscalyear, d.Clientfiscalquarter
--order by 1


-- Invoices by quarter
with c as (
select
	i.Project__Insight__Project__ID [ProjectID]
	, i.Awarded_To_Vendor_Companies_Name [VendorName]
	, i.Awarded_To_Vendor_Companies_Number [VendorNumber]
	, Amount
	, i.Payment_Request_ID
	, d.Clientfiscalquarter
	, d.Clientfiscalyear
	, Check_Date [PaymentDate]
	,   case when [Awarded_To_Vendor_Companies_Name] like '%Avara Construction%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%Corti Construction Inc%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%Davis Schueller%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%Gateway Construction Services%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%GLY%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%HSW (Balfour Beatty, DBA HOWARD S WRIGHT)%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%LEASE CRUTCHER LEWIS WA, LLC %' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%OMEGA SERVICES AND SUPPLY (DBA Omega General Contractors)%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%Schuchart%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%Skanska%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%SWINERTON BUILDERS (WA)%' Then 'GC'
when [Awarded_To_Vendor_Companies_Name] like '%General%' Then 'GC'
when Awarded_To_Vendor_Companies_Name like '%Hitt%Cont%' then 'GC'
when Awarded_To_Vendor_Companies_Name like '%Gateway%' then 'GC'
when Awarded_To_Vendor_Companies_Number = 269392 then 'GC'
	end [TradeType]
from Fact_CPS_PI_Project_Invoices i
left join Dim_Build_Date d
		on cast(i.Check_Date as date) = cast(d.SQLdate as date)
inner join VW_FullProjectList pl
	on cast(i.Project__Insight__Project__ID as varchar) = cast(pl.[Project ID] as varchar)
where Clientfiscalyear in (2021, 2022) and pl.Program not in ('Redwest South','Development')
)
select ProjectID
	, VendorName
	, VendorNumber
	, Amount
	, PaymentDate
	, Payment_Request_ID
	, concat(Clientfiscalyear,'Q',Clientfiscalquarter) ClientFYQuarter
from c
where TradeType like 'GC'
group by 
	Clientfiscalyear
	, Clientfiscalquarter
	, Payment_Request_ID
	, TradeType
	, ProjectID
	, VendorName
	, VendorNumber
	, Amount
	, PaymentDate
order by 1


--select * from Fact_CPS_PI_Project_Invoices
--select distinct program from VW_FullProjectList