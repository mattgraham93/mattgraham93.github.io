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
	
from (select distinct created,Project_Status,FM_Project__Descriptors_MS_Region,FM_Project__Descriptors_Current__Total__PM_Estimate,Project__Insight__Project__ID from snp.Project_Information_20200630) I
left join snp.Project_Milestones_20200630 c on c.Project__Insight__Project__ID = I.Project__Insight__Project__ID
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
	and c.FM_Project__Milestones_Actual_Project_Complete between '7-1-2019' and '6-30-2020'
	or Project_Status in('Under Development', 'Active', 'Closeout')
	 and FM_Project__Descriptors_Current__Total__PM_Estimate >5

 )
) x
where TPVBracket is not null --and FM_Project__Descriptors_Current__Total__PM_Estimate <> 0.00
group by TPVBracket 