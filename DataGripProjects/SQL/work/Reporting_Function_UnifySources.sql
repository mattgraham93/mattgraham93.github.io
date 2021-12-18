drop function ufnGetBuildActuals

create function ufnGetBuildActuals()
returns table 
as
return
(SELECT [PKCProjectNUM] AS 'Project ID', 
		NULL AS 'SAP Number'
		/*,[GL_FISCAL_YEAR]+1 AS F_Y*/ , 
		CASE 
			WHEN [PerNo] IN (1, 2, 3, 4, 5, 6, 7, 8, 9) THEN CONCAT('20', [FY] + 1, '0', [PerNo]) 
			ELSE CONCAT('20', [FY] + 1, [PerNo]) 
		END 'Fiscal Period',
		[AMOUNT] AS 'Amount', 
		'Opex' AS 'Capex/Opex', 
		'Non-SAP' AS 'Asset Class',
		'JDE Spend' AS 'Transaction Type' 
	FROM Fact_Build_JDE_GLExport 
	WHERE [LT] = 'AZ' 
		AND [DoTy] = 'PZ' 
		AND [BUSINESSUNIT] = 'MFMCPS' 
		AND [OBJACCT] = 76750 
		AND [SUB] = 120 OR [BUSINESSUNIT] = 'MFMSPLCR' 
	
	UNION ALL 

	--JDE Non-SAP Non-LCR 
	SELECT [PKCProjectNUM] AS 'Project ID', 
		NULL AS 'SAP Number'
		/*,[GL_FISCAL_YEAR]+1 AS F_Y*/ , 
		CASE 
			WHEN [PerNo] IN (1, 2, 3, 4, 5, 6, 7, 8, 9) THEN CONCAT('20', [FY] + 1, '0', [PerNo]) 
			ELSE CONCAT('20', [FY] + 1, [PerNo]) 
		END 'Fiscal Period',
		[AMOUNT] AS 'Amount', 
		'Opex' AS 'Capex/Opex', 
		'Non-SAP' AS 'Asset Class',
		'JDE Net Accruals' AS 'Transaction Type' 
	FROM Fact_Build_JDE_GLExport 
	WHERE [LT] = 'AZ' 
		AND [DoTy] = 'JZ' 
		AND [BUSINESSUNIT] = 'MFMCPS' 
		AND [OBJACCT] = 76750 
		AND [SUB] = 120 OR [BUSINESSUNIT] = 'MFMSPLCR' 

	UNION ALL 

	-- Accruals 

	SELECT [Project ID] AS 'Project ID', 
		[SAP PS Project Number] AS 'SAP Number', 
		[Fiscal Period] AS 'Fiscal Period', 
		[Amount],  
		[Capex/Opex]/*there is no way to tell what asset class each accrual belongs, but each accrual is categorized as capex or opex, so using that to estimate asset class*/ ,  
		CASE 
			WHEN [Capex/Opex] = 'Capex' THEN 'Furniture' 
			ELSE 'Building' 
		END AS 'Asset Class', 
		CASE 
			WHEN [TransactionType] = 'Accrual' THEN 'SAP Accrual' 
			WHEN [TransactionType] = 'Reversal' THEN 'SAP Reversal' 
			ELSE NULL 
		END AS 'Transaction Type' 
	FROM Fact_Build_Accruals_Final

	UNION ALL 

	--Accruals 

	SELECT [Project ID] AS 'Project ID', 
		[SAP Num] AS 'SAP Number', 
		[Fiscal Period], 
		[Amount], 
		[Capex/Opex], 
		[Asset Class]/*Adjustmets is temp until Aharon adds final column to the upload and SQL Table*/ ,  
		'Adjustment' AS 'Transaction Type' 
	FROM Fact_Build_Adjustments

	UNION ALL 

	-- SAP Vendor Spend 
	/*
		All WBS codes with a length > 20 are excluded as they are not Puget Sound projects
	*/

	select null 'Project ID',
		[Project Definition] 'SAP Number',
		CASE 
			WHEN [Per] IN (1, 2, 3, 4, 5, 6, 7, 8, 9) THEN CONCAT([Year], '0', [Per]) 
			ELSE CONCAT([Year], [Per]) 
		END 'Fiscal Period',
		[Val/CO Area Crcy] 'Amount',
		null 'Capex/Opex',
		[AssetClass Name - TI] 'AssetClass',
		'SAP Spend' 'Transaction Type'
	from Fact_Build_SAP_VendorSpend vs
		inner join vw_Build_FinWBScodes wc
			on dbo.uFnRemoveProjectFromWBSCode(Object) = wc.[Full WBS Code]
	)
go


create view vw_Fact_Build_TeamActuals as
	select *
	from dbo.ufnGetBuildActuals()

select * from vw_Fact_Build_TeamActuals
