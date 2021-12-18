select [Project ID], [Fiscal Period], [Vendor Name], [PI PO #], [SAP PO #], Amount, AzureLoadDate
from Fact_Build_Accruals_Final
where [Project ID] in ('PS0049') and [Fiscal Period] like '202111'
order by AzureLoadDate desc;

-- proposed solution: join to full project list, remove accrual line when rowcnt > 1 and fiscal period = 202110, duplicate exist in 202110 when marked as accrual



with c as(
select
	ROW_NUMBER() over (partition by [Project ID], [Fiscal Period], Amount, TransactionType order by AzureLoadDate desc)
		as rowCnt, [Project ID], [Fiscal Period], Amount, AzureLoadDate, TransactionType
from Fact_Build_Accruals_Final 
)
select rowCnt, c.[Project ID], [Fiscal Period], Amount, AzureLoadDate, TransactionType from c
	inner join VW_FullProjectList fpl
		on c.[Project ID] = fpl.[Project ID]
where rowCnt > 1 and [Fiscal Period] like '202110' and TransactionType like 'Accrual'
--and ([Project ID] in ('209362', '208977') and [Fiscal Period] like '202110')


with c as(
select
	ROW_NUMBER() over (partition by [Project ID], [Fiscal Period], Amount, TransactionType order by AzureLoadDate desc)
		as rowCnt, [Project ID], [Fiscal Period], Amount, AzureLoadDate, TransactionType
from Fact_Build_Accruals_Final 
)
select rowCnt, c.[Project ID], [Fiscal Period], Amount, AzureLoadDate, TransactionType from c
	inner join VW_FullProjectList fpl
		on c.[Project ID] = fpl.[Project ID]
where rowCnt = 1 and (([Fiscal Period] like '202110' and TransactionType like 'Accrual') or ([Fiscal Period] like '202111' and TransactionType like 'Reversal') )



with c as(
select
	ROW_NUMBER() over (partition by [Project ID], [Fiscal Period], Amount, TransactionType order by AzureLoadDate desc)
		as rowCnt, [Project ID], [Fiscal Period], Amount, AzureLoadDate, TransactionType
from Fact_Build_Accruals_Final 
)
delete from c
where rowCnt > 1 and (([Fiscal Period] like '202110' and TransactionType like 'Accrual') or ([Fiscal Period] like '202111' and TransactionType like 'Reversal') )



-- PID 105025, FP 202110, Am 109413


--with c as(
--select
--	ROW_NUMBER() over (partition by [Project ID], [Fiscal Period], Amount, TransactionType, AzureLoadDate order by AzureLoadDate desc)
--		as rowCnt, [Project ID], [Fiscal Period], Amount, AzureLoadDate, TransactionType
--from Fact_Build_Accruals_Final 
--)
--select distinct c.[Project ID], [Fiscal Period], rowCnt, AzureLoadDate
--from c
--	inner join VW_FullProjectList fpl
--		on c.[Project ID] = fpl.[Project ID]
--where rowCnt > 1
--order by AzureLoadDate desc