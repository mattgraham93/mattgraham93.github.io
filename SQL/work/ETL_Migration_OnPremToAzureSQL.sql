-- ===========================================================
-- Create external data source template for Azure SQL Database
-- ===========================================================
IF EXISTS (
  SELECT *
    FROM sys.external_data_sources
    WHERE name = N'<data_source_name, sysname, sample_data_source>'
)
DROP EXTERNAL DATA SOURCE matsqlprod01_JDEFeed
GO


create database scoped credential matsqlprodadmin
with
	identity = 'CBRE_Build_SQLIntegration_Account',
	secret = 'H@z3yCaliper$';

CREATE EXTERNAL DATA SOURCE matsqlprod01_JDEFeed WITH
(
    type = rdbms,
	LOCATION = 'sqlserver://matsqlprod01:1533',
    CREDENTIAL = matsqlprodadmin,
	database_name = 'JDEFeed'
)
GO

create table dbo.Fact_Build_JDE_GLExport (
	[Company] [varchar](10) NULL,
	[BusinessUnit] [varchar](100) NULL,
	[ObjAcct] [varchar](10) NULL,
	[Sub] [varchar](10) NULL,
	[SubType] [varchar](100) NULL,
	[SubLedger] [varchar](100) NULL,
	[DoTy] [varchar](100) NULL,
	[DocumentNumber] [varchar](100) NULL,
	[LT] [varchar](100) NULL,
	[JELineNumber] [varchar](100) NULL,
	[PayItm] [varchar](100) NULL,
	[GLDate] [varchar](100) NULL,
	[PerNo] [varchar](100) NULL,
	[FY] [varchar](100) NULL,
	[Century] [varchar](100) NULL,
	[BatchNumber] [varchar](100) NULL,
	[BatchDate] [varchar](100) NULL,
	[PaymentID] [varchar](100) NULL,
	[AddressNumber] [varchar](100) NULL,
	[ExplanationAlphaName] [varchar](100) NULL,
	[ExplanationRemark] [varchar](100) NULL,
	[Reference1] [varchar](100) NULL,
	[PC] [varchar](100) NULL,
	[Amount] [varchar](100) NULL,
	[Units] [varchar](100) NULL,
	[RV] [varchar](100) NULL,
	[CurrCode] [varchar](100) NULL,
	[OLeaseORWID] [varchar](100) NULL,
	[PurchaseOrder] [varchar](100) NULL,
	[POLINEID] [varchar](100) NULL,
	[PODescriptionLine1] [varchar](1000) NULL,
	[PODescriptionLine2] [varchar](1000) NULL,
	[PaymentNumber] [varchar](100) NULL,
	[DateCheck] [varchar](100) NULL,
	[SInvoiceNumber] [varchar](100) NULL,
	[InvoiceDate] [varchar](100) NULL,
	[BusinessUnitType] [varchar](100) NULL,
	[PostEditBU] [varchar](100) NULL,
	[AccountNumber] [varchar](100) NULL,
	[ACCDescription] [varchar](100) NULL,
	[MSFPONUM] [varchar](100) NULL,
	[ExpesiteProjectNUM] [varchar](100) NULL,
	[PISIPONUM] [varchar](100) NULL,
	[PKCProjectNUM] [varchar](100) NULL,
	[ALTCE] [varchar](100) NULL,
	[BU23] [varchar](100) NULL,
	[BU21] [varchar](100) NULL,
	[CatCode] [varchar](100) NULL,
	[CatCodeDesc] [varchar](100) NULL,
	[UserID] [varchar](100) NULL,
	[DateUpdated] [varchar](100) NULL,
	[TimeUpdated] [varchar](100) NULL
)

select * from Fact_Build_JDE_GLExport