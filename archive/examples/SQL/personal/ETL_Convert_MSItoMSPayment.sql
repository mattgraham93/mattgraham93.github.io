
-- this query shows MSI invoices and payments that have matching amounts in SAP over one PO
select i.Project__Insight__Project__ID [ProjectID],
	i.MS_Project__Number___PI___or__P____ [SAPNumber],
	m.MSContact,
	-- always show PI invoice numbers
	pinv.Name [InvoiceNumber],
	-- always show SAP PO number
	i.FM_Project__Descriptors_SAP_PO_ [PONumber],
	m.PaymentDocNo,
	m.InvoiceAmount,
	m.Status,
	m.posted,
	-- pull submitted and invoice date and amount
	m.SubmitDate,
	m.InvoiceDate,
	-- Always show SAP payment date
	vs.[Postg Date] [PaymentDate]
	--, d.clientperiod
	-- concat PI invoice values and PO numbers
	, concat(pinv.Name,i.FM_Project__Descriptors_SAP_PO_) 'Invoice#PONumber#'
	--,sum(vs.[Val/CO Area Crcy]) [SAP Amount]
from [dbo].[Fact_Build_MSI_Invoice_Data] m
	left join 
		(select Project__Insight__Project__ID, [FM_Project__Descriptors_SAP_PO_], MS_Project__Number___PI___or__P____ from [dbo].[Fact_CPS_PI_Project_Information]) i
		-- need to find a way to isolate one step below PO number since multiple PI IDs can be on a single PO
		on i.[FM_Project__Descriptors_SAP_PO_] = cast(m.PONumber as varchar)
	-- get payment date based on payment doc number logged in msi invoice (not in sap vendor spend)
	left join 
		(select distinct PaymentDocNo, PaymentDate from [dbo].[fact_Build_MSI_Payments] )p
		on m.PaymentDocNo =p.PaymentDocNo
	-- join all items that have the same PO number and invoice/dollar amount from MSI payments and compare to SAP spend
	-- SAP vendor spend is source of truth
	left join (select distinct [Postg Date], PurchDoc, RefDocNo,[Val/CO Area Crcy], [Doc Date] from Fact_Build_SAP_VendorSpend) vs
		on vs.PurchDoc = cast(m.PONumber as nvarchar) and vs.RefDocNo = m.MSInvoiceNumber
	--inner join [dbo].[Dim_Build_Date] d
	--	on d.sqldate = vs.[Postg Date]
	-- only show rows where we have matching invoices
	inner join (select Project__Insight__Project__ID, name from Fact_CPS_PI_Project_Invoices) pinv
		on InvoiceNumber = pinv.Name and i.Project__Insight__Project__ID = pinv.Project__Insight__Project__ID
group by 
	i.Project__Insight__Project__ID,
	i.MS_Project__Number___PI___or__P____,
	m.PONumber,
	m.MSContact,
	m.Status,
	m.posted,
	m.SubmitDate,
	m.InvoiceDate,
	m.InvoiceAmount,
	m.PaymentDocNo
	--,d.clientperiod
	,p.PaymentDate
	,vs.[Postg Date]
	,Name
	,FM_Project__Descriptors_SAP_PO_
-- some PO's are routed in multiple amounts that sum to the invoice amount. otherwise, it will sum the single, full amount.
having sum([Val/CO Area Crcy]) = m.InvoiceAmount
-- w/o dist. 7062. w/ dist. 7065. having 1



--select * from Fact_Build_MSI_Invoice_Data
--where InvoiceNumber like '7069082-06'

--select * from Fact_Build_MSI_Payments
--where PaymentDocNo like '1508891068'

select * 
--,sum([Val/CO Area Crcy]) 
from Fact_Build_SAP_VendorSpend
where PurchDoc like '470036165' and RefDocNo like '5726954590'
	inner join invoice
-- 17960.38

--select inf.Project__Insight__Project__ID, 
--	[FM_Project__Descriptors_SAP_PO_]
--	, inv.Commitments_Commitment_ID
--	, inv.Check_Number
--	, inv.Commitments_Name
--	, inv.Commitments_Number
--	, inv.Amount
--	, inv.Name
--from [dbo].[Fact_CPS_PI_Project_Information] inf
--	left join Fact_CPS_PI_Project_Invoices inv
--		on inf.Project__Insight__Project__ID = inv.Project__Insight__Project__ID
--where FM_Project__Descriptors_SAP_PO_ like '470036079'


--select * from Fact_CPS_PI_Project_Invoices
--where name like '209334-PM1'