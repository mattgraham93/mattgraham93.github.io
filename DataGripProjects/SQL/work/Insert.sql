USE [DATProd01]
GO

INSERT INTO [dbo].[XML_Test]
           ([Company]
           ,[BusinessUnit]
           ,[ObjAcct]
           ,[Sub]
           ,[SubType]
           ,[SubLedger]
           ,[DoTy]
           ,[DocumentNumber]
           ,[LT]
           ,[JELineNumber]
           ,[PayItm]
           ,[GLDate]
           ,[PerNo]
           ,[FY]
           ,[Century]
           ,[BatchNumber]
           ,[BatchDate]
           ,[PaymentID]
           ,[AddressNumber]
           ,[ExplanationAlphaName]
           ,[ExplanationRemark]
           ,[Reference1]
           ,[PC]
           ,[Amount]
           ,[Units]
           ,[RV]
           ,[CurrCode]
           ,[OLeaseORWID]
           ,[PurchaseOrder]
           ,[POLINEID]
           ,[PODescriptionLine1]
           ,[PODescriptionLine2]
           ,[PaymentNumber]
           ,[DateCheck]
           ,[SInvoiceNumber]
           ,[InvoiceDate]
           ,[BusinessUnitType]
           ,[PostEditBU]
           ,[AccountNumber]
           ,[ACCDescription]
           ,[MSFPONUM]
           ,[ExpesiteProjectNUM]
           ,[PISIPONUM]
           ,[PKCProjectNUM]
           ,[ALTCE]
           ,[BU23]
           ,[BU21]
           ,[CatCode]
           ,[CatCodeDesc]
           ,[UserID]
           ,[DateUpdated]
           ,[TimeUpdated])
select
	MY_XML.JDE.query('Company').value('.', 'varchar(10)'),
	MY_XML.JDE.query('BusinessUnit').value('.', 'varchar(100)'),
	MY_XML.JDE.query('ObjAcct').value('.', 'varchar(10)',
	MY_XML.JDE.query('Sub').value('.', 'varchar(10)',
	MY_XML.JDE.query('SubType').value('.', 'varchar(100)',
	MY_XML.JDE.query('SubLedger').value('.', 'varchar(100)',
	MY_XML.JDE.query('DoTy').value('.', 'varchar(100)',
	MY_XML.JDE.query('DocumentNumber').value('.', 'varchar(100)',
	MY_XML.JDE.query('LT').value('.', 'varchar(100)',
	MY_XML.JDE.query('JELineNumber').value('.', 'varchar(100)',
	MY_XML.JDE.query('PayItm').value('.', 'varchar(100)',
	MY_XML.JDE.query('GLDate').value('.', 'varchar(100)',
	MY_XML.JDE.query('PerNo').value('.', 'varchar(100)',
	MY_XML.JDE.query('FY').value('.', 'varchar(100)',
	MY_XML.JDE.query('Century').value('.', 'varchar(100)',
	MY_XML.JDE.query('BatchNumber').value('.', 'varchar(100)',
	MY_XML.JDE.query('BatchDate').value('.', 'varchar(100)',
	MY_XML.JDE.query('PaymentID').value('.', 'varchar(100)',
	MY_XML.JDE.query('AddressNumber').value('.', 'varchar(100)',
	MY_XML.JDE.query('ExplanationAlphaName').value('.', 'varchar(100)',
	MY_XML.JDE.query('ExplanationRemark 'varchar(100)',
	MY_XML.JDE.query('Reference1 'varchar(100)',
	MY_XML.JDE.query('PC 'varchar(100)',
	MY_XML.JDE.query('Amount 'varchar(100)',
	MY_XML.JDE.query('Units 'varchar(100)',
	MY_XML.JDE.query('RV 'varchar(100)',
	MY_XML.JDE.query('CurrCode 'varchar(100)',
	MY_XML.JDE.query('OLeaseORWID 'varchar(100)',
	MY_XML.JDE.query('PurchaseOrder 'varchar(100)',
	MY_XML.JDE.query('POLINEID 'varchar(100)',
	MY_XML.JDE.query('PODescriptionLine1 'varchar(1000)',
	MY_XML.JDE.query('PODescriptionLine2 'varchar(1000)',
	MY_XML.JDE.query('PaymentNumber 'varchar(100)',
	MY_XML.JDE.query('DateCheck 'varchar(100)',
	MY_XML.JDE.query('SInvoiceNumber 'varchar(100)',
	MY_XML.JDE.query('InvoiceDate 'varchar(100)',
	MY_XML.JDE.query('BusinessUnitType 'varchar(100)',
	MY_XML.JDE.query('PostEditBU 'varchar(100)',
	MY_XML.JDE.query('AccountNumber 'varchar(100)',
	MY_XML.JDE.query('ACCDescription 'varchar(100)',
	MY_XML.JDE.query('MSFPONUM 'varchar(100)',
	MY_XML.JDE.query('ExpesiteProjectNUM 'varchar(100)',
	MY_XML.JDE.query('PISIPONUM 'varchar(100)',
	MY_XML.JDE.query('PKCProjectNUM 'varchar(100)',
	MY_XML.JDE.query('ALTCE 'varchar(100)',
	MY_XML.JDE.query('BU23 'varchar(100)',
	MY_XML.JDE.query('BU21 'varchar(100)',
	MY_XML.JDE.query('CatCode 'varchar(100)',
	MY_XML.JDE.query('CatCodeDesc 'varchar(100)',
	MY_XML.JDE.query('UserID 'varchar(100)',
	MY_XML.JDE.query('DateUpdated 'varchar(100)',
	MY_XML.JDE.query('TimeUpdated 'varchar(100)'
from (select cast(MY_XML as xml)
	from openrowset(bulk 'C:\Users\v-magrah\Documents\20210507_GLExport.xml', single_blob) as T(MY_XML)) as T(MY_XML)
	cross apply MY_XML.nodes('GLExportRow') as MY_XML (JDE);
