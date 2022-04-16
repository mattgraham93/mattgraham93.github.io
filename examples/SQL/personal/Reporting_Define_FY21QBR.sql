select count(i.Project__Insight__Project__ID )as id from snp.Project_Information_20210630 i,snp.Project_Milestones_20210630 M
where i.Project__Insight__Project__ID =m.Project__Insight__Project__ID
and Project_Status in( 'Complete') 
and m.FM_Project__Milestones_Actual_Project_Complete between '4-1-2021' and '6-30-2021'
and  [FM_Project__Descriptors_MS_Region]in ('PUGET SOUND','PS Lifecycle Renewal','PS Project Delivery Business','PS Lab Services')
and [FM_Project__Descriptors_Budget__Delivery__Owner] <> 'FM NAFS Budget- FM NAFS Delivery'
and [FM_Project__Descriptors_Budget__Delivery__Owner]<> 'CPS NAFS Budget- FM NAFS Delivery' 
and [FM_Project__Descriptors_Budget__Delivery__Owner] <> 'Integrator Budget - Integrator Delivery'


select count(i.Project__Insight__Project__ID )as id from snp.Project_Information_20210630 i,snp.Project_Milestones_20210630 M
where i.Project__Insight__Project__ID =m.Project__Insight__Project__ID
and Project_Status in( 'Cancelled') 
and m.FM_Project__Milestones_Actual_Project_Complete between '4-1-2021' and '6-30-2021'
and  [FM_Project__Descriptors_MS_Region]in ('PUGET SOUND','PS Lifecycle Renewal','PS Project Delivery Business','PS Lab Services')
and [FM_Project__Descriptors_Budget__Delivery__Owner] <> 'FM NAFS Budget- FM NAFS Delivery'
and [FM_Project__Descriptors_Budget__Delivery__Owner]<> 'CPS NAFS Budget- FM NAFS Delivery' 
and [FM_Project__Descriptors_Budget__Delivery__Owner] <> 'Integrator Budget - Integrator Delivery'



--TPV Value

select TPVBracket, count(Project__Insight__Project__ID)projCount, format(sum(FM_Project__Descriptors_Current__Total__PM_Estimate),'N0')TPV--, format(sum(cast(amount as decimal)),'N0')TPV
from(
select distinct 
	case	
		when FM_Project__Descriptors_Current__Total__PM_Estimate < 250000
		then '1_Under $250K'
		when FM_Project__Descriptors_Current__Total__PM_Estimate > 4000000
		then '3_Over $4M'
		when FM_Project__Descriptors_Current__Total__PM_Estimate between 250000 and 4000000
		then '2_$250 - $4M'
	end TPVBracket,
	FM_Project__Descriptors_Current__Total__PM_Estimate,
	I.Project__Insight__Project__ID--,
	--FM_Project__Descriptors_MS_Region--,amount
	
from (select distinct created,Project_Status,FM_Project__Descriptors_MS_Region,FM_Project__Descriptors_Current__Total__PM_Estimate,Project__Insight__Project__ID from snp.Project_Information_20210630) I
left join snp.Project_Milestones_20210630 c on c.Project__Insight__Project__ID = I.Project__Insight__Project__ID
--left join BuildTeamReportingPlatform.dbo.Final_Accruals A on A.[Project Insight ID] = I.Project__Insight__Project__ID
where   

(FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')  
and(
	Project_Status in('Complete', 'Cancelled'  )
	-- and (
		--(datepart(year,cast(Executed as date) ) =  '2019' ) or 
		--(datepart(year,cast(Issued as date) ) =  '2019' ) or 
		--(datepart(year,cast(Completed as date) ) =  '2019' ) or 
		--(datepart(year,cast(I.created as date) ) =  '2019' ) 
	-- ) or
	--and (
	--	(cast(Executed as date) <=  '6-30-2020' and cast(Executed as date) >= '7-1-2019') 
	--	or (cast(Issued as date) <=  '6-30-2020' and cast(Issued as date) >= '7-1-2019')
	--	or (cast(Completed as date) <=  '6-30-2020' and cast(Completed as date) >= '7-1-2019')
	--	or (cast(I.created as date) <=  '6-30-2020' and cast(I.created as date) >= '7-1-2019')
	--)
	and c.FM_Project__Milestones_Actual_Project_Complete between '7-1-2020' and '6-30-2021'
	or Project_Status in('Under Development', 'Active', 'Closeout')
	 and FM_Project__Descriptors_Current__Total__PM_Estimate >5

 )
) x
where TPVBracket is not null --and FM_Project__Descriptors_Current__Total__PM_Estimate <> 0.00
group by TPVBracket 

select count(Project__Insight__Project__ID)
from snp.Project_Information_20210630 I
where Project_Status in('Active')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')

select count(Project__Insight__Project__ID)
from snp.Project_Information_20210630 I
where Project_Status in('Under Development')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')

select count(Project__Insight__Project__ID)
from snp.Project_Information_20210630 I
where Project_Status in('On Hold')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')

select count(Project__Insight__Project__ID)
from snp.Project_Information_20210630 I
where Project_Status in('Future')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')

select count(Project__Insight__Project__ID)
from snp.Project_Information_20210630 I
where Project_Status in('Closeout')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%')



-- Building list to distribute to PMs on request from Johanna > consolidate and get distinct buildings
select * from (select Project__Insight__Project__ID,Name,Project_Status,CBRE_Project__Manager_Users_Contacts_Full_Name,FM_Project__Descriptors_Project__Type,FM_Project__Descriptors_Building__Name, (len(FM_Project__Descriptors_Building__Name) -
len(REPLACE(FM_Project__Descriptors_Building__Name, ',', '')) + 1) as BlndCnt
from snp.Project_Information_20210630 I
where Project_Status in('Active','Under Development')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%'))x
--where x.blndcnt>=10

-- Total list of buildings where each project has fewer than 10 activities > include all
select distinct z.value from (select distinct Value from (select bldngname from (select FM_Project__Descriptors_Building__Name as bldngname, (len(FM_Project__Descriptors_Building__Name) -
len(REPLACE(FM_Project__Descriptors_Building__Name, ',', '')) + 1) as BlndCnt
from snp.Project_Information_20210630 I
where Project_Status in('Active','Under Development')
and (FM_Project__Descriptors_MS_Region like '%ps%'or FM_Project__Descriptors_MS_Region like '%PUGET%'))x
--where x.blndcnt<10
)y
cross apply STRING_SPLIT (y.bldngname, ',') 
where value is not null)z
