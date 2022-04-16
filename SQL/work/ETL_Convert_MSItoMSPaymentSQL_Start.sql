-- m = msi invoice
-- i = project info (in PI)
-- d = dim_date
-- p = msi payment

--select i.Project__Insight__Project__ID,
--	m.InvoiceNumber,
--	m.PONumber,
--	m.MSContact,
--	m.Status,
--	m.posted,
--	m.SubmitDate,
--	m.InvoiceDate,
--	m.InvoiceAmount,
--	p.PaymentDate,
--	d.clientperiod,
--	-- concat invoice and PO number (will need to throw to lower around)
--	concat(m.InvoiceNumber,m.PONumber) 'Invoice#PONumber#',
--	m.InvoiceNumber,
--	m.PONumber
--from [dbo].[Fact_Build_MSI_Invoice_Data] m
--	left join 
--		(select Project__Insight__Project__ID, [FM_Project__Descriptors_SAP_PO_] from [dbo].[Fact_CPS_PI_Project_Information]) i
--		on i.[FM_Project__Descriptors_SAP_PO_] = cast(m.PONumber as varchar)
--	left join 
--		(select distinct PaymentDocNo, PaymentDate from [dbo].[fact_Build_MSI_Payments] )p
--		on m.PaymentDocNo =p.PaymentDocNo
--	left join [dbo].[Dim_Build_Date] d
--		on d.sqldate = p.paymentdate


--select RefDocNo, PurchDoc, [Postg Date], [Doc Date] from Fact_Build_SAP_VendorSpend
---- removes ~10k rows
--where PurchDoc in 
--	-- payment docs only return nums starting with 1
--	(select distinct cast(PaymentDocNo as nvarchar(50)) from [dbo].[fact_Build_MSI_Payments])


with c as (
select i.Project__Insight__Project__ID,
	m.InvoiceNumber,
	m.PONumber,
	m.MSContact,
	m.Status,
	m.posted,
	m.SubmitDate,
	m.InvoiceDate,
	m.InvoiceAmount,
	-- gets payment date from payment table
	-- need to display SAP payment if different from each other
	m.PaymentDocNo,
	d.clientperiod,
	-- concat invoice and PO number (will need to throw to lower around)
	concat(m.InvoiceNumber,m.PONumber) 'Invoice#PONumber#'
	,p.PaymentDate [MSI Payment date]
	,vs.[Postg Date] [SAP Post date]
	,vs.[Doc Date] [SAP Doc date]
	,vs.[Val/CO Area Crcy] [SAP Amount]
	, Clientfiscalperiod
from [dbo].[Fact_Build_MSI_Invoice_Data] m
	left join 
		(select Project__Insight__Project__ID, [FM_Project__Descriptors_SAP_PO_] from [dbo].[Fact_CPS_PI_Project_Information]) i
		on i.[FM_Project__Descriptors_SAP_PO_] = cast(m.PONumber as varchar)
	-- get payment date based on payment doc number logged in msi invoice (not in sap vendor spend)
	left join 
		(select distinct PaymentDocNo, PaymentDate from [dbo].[fact_Build_MSI_Payments] )p
		on m.PaymentDocNo =p.PaymentDocNo
	left join [dbo].[Dim_Build_Date] d
		on d.sqldate = p.paymentdate
	-- join all items that have the same PO number and invoice/dollar amount from MSI payments and compare to SAP spend
	-- SAP vendor spend is source of truth
	left join (select distinct [Postg Date], PurchDoc, [Val/CO Area Crcy], [Doc Date] from Fact_Build_SAP_VendorSpend) vs
		on vs.PurchDoc = cast(m.PONumber as nvarchar) and vs.[Val/CO Area Crcy] = m.InvoiceAmount and vs.[Postg Date] = cast(d.SQLdate as date)
), d as (
select Invoice#PONumber#, InvoiceAmount, [SAP Amount], InvoiceDate, [MSI Payment date], max([SAP Post date]) SAPPostDate
	, DATEDIFF(day, [MSI Payment date], [SAP Post date]) [DateDiff],
	ClientPeriod [SAPClientPeriod]
	--,Clientfiscalperiod, Clientperiod
from c
group by Invoice#PONumber#, InvoiceDate, [MSI Payment date], InvoiceAmount, [SAP Amount], [SAP Post date], ClientPeriod
)
select Invoice#PONumber#, InvoiceAmount, [SAP Amount], InvoiceDate, [MSI Payment date], SAPPostDate, SAPClientPeriod, DateDiff
from d
where [SAP Amount] is not null
--where DateDiff > 0
	--, Clientfiscalperiod, Clientperiod
--where [SAP Post date] is not null

--'Actual spend date' = column name >> To be the reported date
-- try to see a difference between SAP/non-SAP projects
	-- excludes g.'s
-- MSI does not show IW/RWS/MP
-- fix case structure to make all characters upper


--select * from Fact_Build_SAP_VendorSpend
--select * from Fact_Build_MSI_Invoice_Data

--select cast(SQLdate as date) from vw_Build_Dim_Date