select 
	case
		when iwp.[Project ID] like pji.MS_Project__Number___PI___or__P____ or iwp.[Project ID] like pji.Project__Insight__Project__ID
			then 'IW and PI'
		when iwp.[Project ID] is not null and (iwp.[Project ID] not like pji.MS_Project__Number___PI___or__P____ or iwp.[Project ID] not like pji.Project__Insight__Project__ID)
			then 'IW MP-only'
		else 'PI'
	end as ProjectType,
	case
		when iwp.[Project ID] is not null and pji.Project__Insight__Project__ID is not null
			then cast(iwp.[Project ID] as nvarchar)
		when iwp.[Project ID] is null and pji.MS_Project__Number___PI___or__P____ is not null
			then cast(pji.MS_Project__Number___PI___or__P____ as nvarchar)
		when iwp.[Project ID] is null and pji.Project__Insight__Project__ID is not null  
			then cast(pji.Project__Insight__Project__ID as nvarchar)
		else cast(iwp.[Project ID] as nvarchar)
	end as ProjectInsightID,
	case 
		when pji.MS_Project__Number___PI___or__P____ is null and pji.Project__Insight__Project__ID is not null 
			then cast(pji.Project__Insight__Project__ID as varchar)
		when pji.MS_Project__Number___PI___or__P____ is null and pji.Project__Insight__Project__ID is null 
			then cast(iwp.[Project ID] as varchar)
		else pji.MS_Project__Number___PI___or__P____
	end as MSProjectID,
	case 
		when iwp.[SAP Number] is null 
			then pji.FM_Project__Descriptors_SAP__
		else iwp.[SAP Number]
	end as SAPNumber,
	case
		when iwp.[Project Status] is null
			then pji.Project_Status
		else iwp.[Project Status]
	end as ProjectStatus,
	case
		when iwp.[RE&F LOB Manager] is null
			then pji.RE_F_Portfolio__LOB_Manager_Users_Contacts_Full_Name
		else iwp.[RE&F LOB Manager]
	end as REFLOBManager,
	case
		when iwp.[CBRE Project Manager] is null
			then pji.CBRE_Project__Manager_Users_Contacts_Full_Name
		else iwp.[CBRE Project Manager]
	end as CBREProjectManager,
	case
		when iwp.[CB Region/Portfolio] is null and pji.FM_Project__Descriptors_MS_Region is not null
			then pji.FM_Project__Descriptors_MS_Region
		else iwp.[CB Region/Portfolio]
	end as MSRegion,
	pji.FM_Project__Descriptors_MS_Subregion as MSSubregion,
	case
		when iwp.[Project Name] is null
			then pji.Name
		else iwp.[Project Name]
	end as ProjectName,
	case
		when iwp.[Current Total PM Estimate] is null
			then pji.FM_Project__Descriptors_Current__Total__PM_Estimate
		else iwp.[Current Total PM Estimate]
	end as CurrentTotalPMEstimate,
	case 
		when iwp.[Current PER Amount] is null
			then cast(pji.FM_Project__Descriptors_Current__PER_Amount as nvarchar)
		else iwp.[Current PER Amount]
	end as CurrentPERAmount,
	case 
		when iwp.[Approved PER] is null
			then cast(pji.FM_Project__Descriptors_Current__Approved__PER as nvarchar)
		else iwp.[Approved PER]
	end as ApprovedPER,
	case
		when iwp.[Budget Amount] is null
			then pjb.Budget_Amount
		else iwp.[Budget Amount]
	end as BudgetAmount,
	case 
		when iwp.[Total Gross PER] is null
			then cast(pji.FM_Project__Descriptors_Total__Gross__PER as nvarchar)
		else iwp.[Total Gross PER]
	end as TotalGrossPER,
	case
		when iwp.[Routing Iteration] is null
			then pji.FM_Project__Descriptors_Current__PER_Routing__Iteration
		else iwp.[Routing Iteration]
	end as RoutingIteration,
	case
		when iwp.[Funding Owner] is null
			then pji.FM_Project__Descriptors_Project__Funding__Owner
		else iwp.[Funding Owner]
	end as FundingOwner,
	case
		when iwp.[Funding Type] is null
			then pji.FM_Project__Descriptors_Funding__Type
		else iwp.[Funding Type]
	end as FundingType,
	case
		when iwp.[CC/IO] is null
			then pji.FM_Project__Descriptors_MS_I_O_Number
		else iwp.[CC/IO]
	end as MSIONumber,
	case
		when iwp.[CC/IO] is null
			then cast(pji.FM_Project__Descriptors_MS_Cost__Center as int)
	end as MSCostCenter,
	case
		when iwp.[Capital or Expense] is null
			then pji.FM_Project__Descriptors_Capital__or__Expense
		else iwp.[Capital or Expense]
	end as CapitalOrExpense,
	case 
		when iwp.[PER Prefunding Submitted] is null
			then cast(FM_Project__Milestones_Primary_PER_Prefunding_Submitted as nvarchar)
		else iwp.[PER Prefunding Submitted]
	end as PERPrefundingSubmitted,
	case
		when iwp.[PER Prefunding Approved] is null
			then pjm.FM_Project__Milestones_Actual_PER_Prefunding_Approved
		else iwp.[PER Prefunding Approved]
	end as PERPrefundingApproved,
	case 
		when iwp.[PER Submitted] is null
			then cast(pjm.FM_Project__Milestones_Primary_PER_Submitted as nvarchar)
		else iwp.[PER Submitted]
	end as PERSubmitted,
	case
		when iwp.[PER Approved] is null
			then pjm.FM_Project__Milestones_Actual_PER_Approved
		else iwp.[PER Approved]
	end as PERApproved,
	case
		when iwp.[PR Submitted] is null
			then cast(pjm.FM_Project__Milestones_Primary_PR_Submitted as nvarchar)
		else iwp.[PR Submitted]
	end as PRSubmitted,
	case
		when iwp.[PR Approved] is null
			then pjm.FM_Project__Milestones_Actual_PR_Approved
		else iwp.[PR Approved]
	end as PRApproved,
	case 
		when iwp.[SAFE Approver] is null
			then pji.FM_Project__Descriptors_Primary__Business__Division___Safe__Approver
		else iwp.[SAFE Approver]
	end as SAFEApprover,
	case 
		when iwp.[Capital Council Status] is null
			then pji.FM_Project__Descriptors_Capital__Council
		else iwp.[Capital Council Status]
	end as CapitalCouncilStatus,
	case 
		when iwp.[Capital Council CE#] is null
			then pji.FM_Project__Descriptors_Capital__Council__Project__ID_
		else iwp.[Capital Council CE#]
	end as CapitalCouncilID,
	case
		when iwp.[PER Report Comments] is null
			then pji.FM_Project__Descriptors_PER_Report__Comments
		else iwp.[PER Report Comments]
	end as PERReportComments
from Fact_CPS_PI_Project_Information as pji
	full join Fact_Build_IW_ProjectList as iwp
		on FM_Project__Descriptors_SAP__ = [SAP Number]
	full join Fact_CPS_PI_Project_Milestones as pjm
		on pji.Project__Insight__Project__ID = pjm.Project__Insight__Project__ID
	full join Fact_CPS_PI_Project_Budgets as pjb
		on pji.Project__Insight__Project__ID = pjb.Project_Insight_Project_ID
--where iwp.[Project ID] is not null or pji.Project__Insight__Project__ID is not null or pji.MS_Project__Number___PI___or__P____ is not null
--order by 1 asc