with c as 
	(select Awarded_To_Vendor_Companies_Name, 
		count(Project__Insight__Project__ID) ProjectCount,
		sum(cast(Total_Awarded_Amount as int)) AwardedAmount, 
		Awarded_To_Vendor_Companies_Number,
		[Project Status]
		--, Program
		--, fpl.[Site Ownership Type]
		--, Executed
		--, Completed
		,
		case
			when  
				Awarded_To_Vendor_Companies_Name like '%Corti%'
				or Awarded_To_Vendor_Companies_Name like '%Davis%'
				or Awarded_To_Vendor_Companies_Name like '%Lease%'
				or Awarded_To_Vendor_Companies_Name like '%Omega%'
				or Awarded_To_Vendor_Companies_Name like '%Schuch%'
				or Awarded_To_Vendor_Companies_Name like '%Swiner%'
				or Awarded_To_Vendor_Companies_Name like '%GLY%'
				or Awarded_To_Vendor_Companies_Name like '%Avara%'
				or Awarded_To_Vendor_Companies_Name like '%Hitt%'
				or Awarded_To_Vendor_Companies_Name like '%Gateway%'
				or Awarded_To_Vendor_Companies_Number = 269392
					then 'GC'
			when 
				Awarded_To_Vendor_Companies_Name like '%Burgess%'
				or Awarded_To_Vendor_Companies_Name like '%Magell%'
				or Awarded_To_Vendor_Companies_Name like '%B+H%'
				or Awarded_To_Vendor_Companies_Name like '%KDW%'
				or Awarded_To_Vendor_Companies_Name like '%DLR%'
				or Awarded_To_Vendor_Companies_Name like '%JPC%'
				or Awarded_To_Vendor_Companies_Name like '%M Arth%'
				or Awarded_To_Vendor_Companies_Name like '%Gensler%'
				or Awarded_To_Vendor_Companies_Name like '%skb%'
					then 'Architect'
			else 'Other'
		end CompanyType
	from Fact_CPS_PI_Project_Commitments pc
		inner join VW_FullProjectList fpl
			on cast(pc.Project__Insight__Project__ID as varchar) = fpl.[Project ID]
		where Awarded_To_Vendor_Companies_Name is not null 
		--and (
		--	pc.Completed between '2021-07-01' and '2021-09-30'
		--	or Executed between '2021-07-01' and '2021-09-30'
		--	or Issued between '2021-07-01' and '2021-09-30'
		--	)
	group by Awarded_To_Vendor_Companies_Name
		, Awarded_To_Vendor_Companies_Number
		, [Project Status]
		--, Completed
		--, Program
	)

select 
	Awarded_To_Vendor_Companies_Name
	, ProjectCount
	, AwardedAmount
	, CompanyType
	--, Completed
	--, Program
from c
	left join Fact_CPS_PI_Vendors piv
		on c.Awarded_To_Vendor_Companies_Number = piv.Vendor_Company_ID
where companytype in ('GC', 'Architect') and [Project Status] like 'Active'
order by 4, 1 asc
	--, Program




--select * from Fact_CPS_PI_Project_Commitments

--select * from VW_FullProjectList