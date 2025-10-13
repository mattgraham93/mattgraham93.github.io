SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER view [dbo].[vw_CPS_DetailedActuals]
as 
-- Matt Graham (v-magrah)
-- 11/18/21
-- This query shows MSI invoices and payments that have matching amounts in SAP over one PO
with c as (
	select i.Project__Insight__Project__ID [ProjectID],
		i.MS_Project__Number___PI___or__P____ [SAPNumber],
		m.MSContact,
		-- always show PI invoice numbers
		pinv.Name [InvoiceNumber],
		-- always show SAP PO number
		i.FM_Project__Descriptors_SAP_PO_ [PONumber],
		-- pull MSI invoice and payment information
		m.PaymentDocNo,
		m.InvoiceAmount,
		m.Status,
		m.posted,
		m.SubmitDate [InvoiceSubmitted],
		m.InvoiceDate [MSIInvoiceDate],
		p.PaymentDate [MSIPaymentDate],
		-- SAP posted date is the source of truth
		vs.[Postg Date] [SAPPostedDate]
		, d.Clientperiod [SAPClientPeriod]
		, pinv.Awarded_To_Vendor_Companies_Number [PIVendorNumber]
		-- concat PI invoice values and PO numbers for a unique ID
		, concat(pinv.Name,i.FM_Project__Descriptors_SAP_PO_) 'InvoicePONumber'
	from [dbo].[Fact_Build_MSI_Invoice_Data] m
		left join 
			(select Project__Insight__Project__ID, [FM_Project__Descriptors_SAP_PO_], MS_Project__Number___PI___or__P____ from [dbo].[Fact_CPS_PI_Project_Information]) i
			on i.[FM_Project__Descriptors_SAP_PO_] = cast(m.PONumber as varchar)
		-- get payment date based on payment doc number logged in msi invoice (not in sap vendor spend)
		left join 
			(select distinct PaymentDocNo, PaymentDate from [dbo].[fact_Build_MSI_Payments] )p
			on m.PaymentDocNo =p.PaymentDocNo
		-- join all items that have the same PO number and invoice/dollar amount from MSI payments and compare to SAP spend
		-- SAP vendor spend is source of truth
		left join (select distinct [Postg Date], PurchDoc, RefDocNo,[Val/CO Area Crcy], [Doc Date] from Fact_Build_SAP_VendorSpend) vs
			on vs.PurchDoc = cast(m.PONumber as nvarchar) and vs.RefDocNo = m.MSInvoiceNumber
		left join (select sqldate, clientperiod from [dbo].[Dim_Build_Date]) d
			on cast(d.sqldate as date) = cast(vs.[Postg Date] as date)
		-- only show rows where we have matching invoice values AND have the same project. Multiple projects can show on both invoices and projects. this handles that case
		inner join (select Project__Insight__Project__ID, name, Awarded_To_Vendor_Companies_Number from Fact_CPS_PI_Project_Invoices) pinv
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
		,Clientperiod
		,pinv.Awarded_To_Vendor_Companies_Number
	-- some PO's are routed in multiple amounts that sum to the invoice amount. otherwise, it will sum the single, full amount.
	having sum([Val/CO Area Crcy]) = m.InvoiceAmount
)
select ProjectID,
	SAPNumber,
	MSContact,
	[InvoiceNumber],
	PIVendorNumber,
	[PONumber],
	PaymentDocNo,
	InvoiceAmount,
	Status,
	posted,
	[MSIInvoiceDate],
	[InvoiceSubmitted],
	[SAPPostedDate],
	[MSIPaymentDate],
	InvoicePONumber,
	[SAPClientPeriod],
	d2.Clientperiod [MSIPaymentClientPeriod],
	case
		when d2.Clientperiod <> SAPClientPeriod 
			then 'Yes'
		else
			'No'
	end DiffReportingPeriod
	from c
	left join Dim_Build_Date d2
		on cast(c.[MSIPaymentDate] as date) = cast(d2.sqldate as date)
GO
