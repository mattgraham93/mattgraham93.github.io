--JDE Non-SAP LCR 

SELECT [PKCProjectNUM] AS 'PI ID', 
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

SELECT [PKCProjectNUM] AS 'PI ID', 
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

SELECT [Project ID] AS 'PI ID', 
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
		WHEN [TransactionType] = 'Reversal' THEN 'SAP reversal' 
		ELSE NULL 
	END AS 'Transaction Type' 
FROM Fact_Build_Accruals_Final

UNION ALL 

--Accruals 

SELECT [Project ID] AS 'PI ID', 
	[SAP Num] AS 'SAP Number', 
	[Fiscal Period], 
	[Amount], 
	[Capex/Opex], 
	[Asset Class]/*Adjustmets is temp until Aharon adds final column to the upload and SQL Table*/ ,  
	'Adjustment' AS 'Transaction Type' 
FROM Fact_Build_Adjustments

--UNION ALL 
-- SAP Vendor Spend 

/*
Transform SAP vendor spend data into same layout as the sources above and add WBS code mapping table (crossjoin)
Transaction Type “SAP Spend” 

todo: parse string on length
	- if len = 9, 12, or 16 > match to associated declarations
	- if len >= 17, find way to connect all numbers
*/

select object, 
	len(Object) 'WBS Length', 
	len(replace(Object, '.', '')) 'TotalDigits',
	case
		when patindex('%[a-Z]%', Object) > 0 and len(Object) < 11 then
			substring(object, 3, 8)
		when len(Object) >= 11 and len(replace(Object, '.', '')) <= 20 then
			concat(left(object, 3),substring(Object, 10, 15))
		
		-- For cases when the WBS is noted as 22.16249.000.01.09.00.1 > EXCLUDE
		 
		-- when len(Object) >= 17 then
			/*
				break apart strings like above
					Construction code: concat(left(object, 3)
					substring(Object, 10, 15),'More here')

				ideally - call a function to return concatenation and move/replace string values at index
			*/ 
			
	end 'Concat',
	'SAP Spend' 'Transaction Type'
from Fact_Fin_SAP_VendorSpend 
--cross join vw_Build_FinWBScodes wbs
--where len(replace(Object, '.', '')) >= 17
order by 2 desc

/*
	22.16249.000.01.09.00.1
		@ConstructionCostCode = 22
		@WBSAccountingCode = 00.001 > 01.000
		@WBSProjectCode = 09.001

	22.15819.000.29.15.00.2
		@ConstructionCostCode = 22
		@WBSAccountingCode = 00.029
		@WBSProjectCode = 15.002

	03.16941.80.400.5000
		@ConstructionCostCode = 03
		@WBSAccountingCode = 80.400
		@WBSProjectCode = 5000
*/

select
	NULL 'PI ID',
	[Project Definition] 'SAP Number',
	CASE 
		WHEN [Per] IN (1, 2, 3, 4, 5, 6, 7, 8, 9) THEN CONCAT([Year] + 1, '0', [Per]) 
		ELSE CONCAT([Year] + 1, [Per]) 
	END 'Fiscal Period',
	[Value TranCurr] 'Amount', --is this the right column?
	Null 'Asset Class',
	'SAP Spend' 'Transaction Type'
from Fact_Fin_SAP_VendorSpend