with c as (
select 
		case 
			when [Project Definition] not in (select [SAP Number] from VW_FullProjectList)
				then null
			else pl.[Project ID]
		end 'Project ID',
		[Project Definition] 'SAP Number',
		CASE 
			WHEN [Per] IN (1, 2, 3, 4, 5, 6, 7, 8, 9) THEN CONCAT([Year], '0', [Per]) 
			ELSE CONCAT([Year], [Per]) 
		END 'Fiscal Period',
		[Val/CO Area Crcy] 'Amount',
		case
			when pl.[Capital or Expense] like 'Capital' or (pl.[Capital or Expense] like 'Expense' and wc.[AssetClass Name - TI] not like 'Building (TI)')
				then 'CAPEX'
			else 'OPEX'
		end 'Capex/Opex',
		[AssetClass Name - TI] 'AssetClass',
		'SAP Spend' 'Transaction Type'
	from Fact_Build_SAP_VendorSpend vs
		inner join vw_Build_FinWBScodes wc
			on dbo.uFnRemoveProjectFromWBSCode(Object) = wc.[Full WBS Code]
		left join VW_FullProjectList pl
			on vs.[Project Definition] = pl.[SAP Number]
)
select distinct [SAP Number] from c 
where [Project ID] is null