with c as (
	select case 
			when iwp.[project id] like pji.ms_project__number___pi___or__p____
				or iwp.[project id] like pji.project__insight__project__id
				then 'iw and pi'
			when iwp.[project id] is not null
				and (
					iwp.[project id] not like pji.ms_project__number___pi___or__p____
					or iwp.[project id] not like pji.project__insight__project__id
					)
				then 'iw mp-only'
			else 'pi'
			end as projecttype
		,case 
			when iwp.[project id] is not null
				and pji.project__insight__project__id is not null
				then cast(iwp.[project id] as nvarchar)
			when iwp.[project id] is null
				and pji.ms_project__number___pi___or__p____ is not null
				then cast(pji.ms_project__number___pi___or__p____ as nvarchar)
			when iwp.[project id] is null
				and pji.project__insight__project__id is not null
				then cast(pji.project__insight__project__id as nvarchar)
			else cast(iwp.[project id] as nvarchar)
			end as projectinsightid
		,case 
			when pji.ms_project__number___pi___or__p____ is null
				and pji.project__insight__project__id is not null
				then cast(pji.project__insight__project__id as varchar)
			when pji.ms_project__number___pi___or__p____ is null
				and pji.project__insight__project__id is null
				then cast(iwp.[project id] as varchar)
			else pji.ms_project__number___pi___or__p____
			end as msprojectid
		,case 
			when iwp.[sap number] is null
				then pji.fm_project__descriptors_sap__
			else iwp.[sap number]
			end as sapnumber
		,case 
			when iwp.[project status] is null
				then pji.project_status
			else iwp.[project status]
			end as projectstatus
		,case 
			when iwp.[re&f lob manager] is null
				then pji.re_f_portfolio__lob_manager_users_contacts_full_name
			else iwp.[re&f lob manager]
			end as reflobmanager
		,case 
			when iwp.[cbre project manager] is null
				then pji.cbre_project__manager_users_contacts_full_name
			else iwp.[cbre project manager]
			end as cbreprojectmanager
		,case 
			when iwp.[cb region/portfolio] is null
				and pji.fm_project__descriptors_ms_region is not null
				then pji.fm_project__descriptors_ms_region
			else iwp.[cb region/portfolio]
			end as msregion
		,pji.fm_project__descriptors_ms_subregion as mssubregion
		,case 
			when iwp.[project name] is null
				then pji.name
			else iwp.[project name]
			end as projectname
		,case 
			when iwp.[current total pm estimate] is null
				then pji.fm_project__descriptors_current__total__pm_estimate
			else iwp.[current total pm estimate]
			end as currenttotalpmestimate
		,case 
			when iwp.[current per amount] is null
				then cast(pji.fm_project__descriptors_current__per_amount as nvarchar)
			else iwp.[current per amount]
			end as currentperamount
		,case 
			when iwp.[approved per] is null
				then cast(pji.fm_project__descriptors_current__approved__per as nvarchar)
			else iwp.[approved per]
			end as approvedper
		,case 
			when iwp.[budget amount] is null
				then pjb.budget_amount
			else iwp.[budget amount]
			end as budgetamount
		,case 
			when iwp.[total gross per] is null
				then cast(pji.fm_project__descriptors_total__gross__per as nvarchar)
			else iwp.[total gross per]
			end as totalgrossper
		,case 
			when iwp.[routing iteration] is null
				then pji.fm_project__descriptors_current__per_routing__iteration
			else iwp.[routing iteration]
			end as routingiteration
		,case 
			when iwp.[funding owner] is null
				then pji.fm_project__descriptors_project__funding__owner
			else iwp.[funding owner]
			end as fundingowner
		,case 
			when iwp.[funding type] is null
				then pji.fm_project__descriptors_funding__type
			else iwp.[funding type]
			end as fundingtype
		,case 
			when iwp.[cc/io] is null
				then pji.fm_project__descriptors_ms_i_o_number
			else iwp.[cc/io]
			end as msionumber
		,case 
			when iwp.[cc/io] is null
				then cast(pji.fm_project__descriptors_ms_cost__center as int)
			end as mscostcenter
		,case 
			when iwp.[capital or expense] is null
				then pji.fm_project__descriptors_capital__or__expense
			else iwp.[capital or expense]
			end as capitalorexpense
		,case 
			when iwp.[per prefunding submitted] is null
				then cast(fm_project__milestones_primary_per_prefunding_submitted as nvarchar)
			else iwp.[per prefunding submitted]
			end as perprefundingsubmitted
		,case 
			when iwp.[per prefunding approved] is null
				then pjm.fm_project__milestones_actual_per_prefunding_approved
			else iwp.[per prefunding approved]
			end as perprefundingapproved
		,case 
			when iwp.[per submitted] is null
				then cast(pjm.fm_project__milestones_primary_per_submitted as nvarchar)
			else iwp.[per submitted]
			end as persubmitted
		,case 
			when iwp.[per approved] is null
				then pjm.fm_project__milestones_actual_per_approved
			else iwp.[per approved]
			end as perapproved
		,case 
			when iwp.[pr submitted] is null
				then cast(pjm.fm_project__milestones_primary_pr_submitted as nvarchar)
			else iwp.[pr submitted]
			end as prsubmitted
		,case 
			when iwp.[pr approved] is null
				then pjm.fm_project__milestones_actual_pr_approved
			else iwp.[pr approved]
			end as prapproved
		,case 
			when iwp.[safe approver] is null
				then pji.fm_project__descriptors_primary__business__division___safe__approver
			else iwp.[safe approver]
			end as safeapprover
		,case 
			when iwp.[capital council status] is null
				then pji.fm_project__descriptors_capital__council
			else iwp.[capital council status]
			end as capitalcouncilstatus
		,case 
			when iwp.[capital council ce#] is null
				then pji.fm_project__descriptors_capital__council__project__id_
			else iwp.[capital council ce#]
			end as capitalcouncilid
		,case 
			when iwp.[per report comments] is null
				then pji.fm_project__descriptors_per_report__comments
			else iwp.[per report comments]
			end as perreportcomments
	from dbo.fact_cps_pi_project_information as pji
	full outer join dbo.fact_build_iw_projectlist as iwp on pji.fm_project__descriptors_sap__ = iwp.[sap number]
	full outer join dbo.fact_cps_pi_project_milestones as pjm on pji.project__insight__project__id = pjm.project__insight__project__id
	full outer join dbo.fact_cps_pi_project_budgets as pjb on pji.project__insight__project__id = pjb.project_insight_project_id
)
select fpl.[Project ID]
	, fpl.[SAP Number]
	, fpl.[Project Name]
	, fpl.[Project Status]
	, fpl.[CBRE Project Manager]
	, fpl.[RE&F Dev Manager]
	,[Capital or Expense]
	,[CC/IO]
	,[Funding Owner]
	,[Funding Type]
	,[Construction Complete DtC/O]
	,[Current Total PM Estimate]
	,[Total Gross PER]
	,[Current PER Amount]
	,[Current Approved PER]
	,[PER Report Comments]
	,[PER Routing Iteration]
	,[PER Status]
	,[Capital Council CE#]
	,[Approved PER]
	,[PER Submitted]
	,[PER Approved]
	,[PR Submitted]
	,[PR Approved]
	,Program
from c
	left join VW_FullProjectList fpl
		on c.projectinsightid = fpl.[Project ID] or c.sapnumber = fpl.[SAP Number]
where 
	projectstatus not in ('Closeout', 'Cancelled', 'Complete')
	and
	(
		(fundingowner like 'RE&F' and cast(budgetamount as int) >= 250000)
		or
		(fundingowner like 'Client' and cast(budgetamount as int) >= 1000000)
		or
		([CC/IO] = 1708181 and cast([Current Total PM Estimate] as int) >= 500000)
		or
		([CC/IO] = 70310 and cast([Current Total PM Estimate] as int) >= 250000)
	)
	and
	-- originally missing, otherwise gets NORAM
	(msregion like '%PS%' or msregion like '%Puget%')
	-- missing from notes
	and Program not in ('Redwest South','Development','IW','LCR Facilities (Exp)')
	and [Construction Complete DtC/O] <= '2026-07-01'