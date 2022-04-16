select FM_Project__Descriptors_Capital__or__Expense, count(distinct Project__Insight__Project__ID) ProjectCount
from snp.Project_Information_20210930
where Project_Status in ('Active','Under development') and FM_Project__Descriptors_Project__Type like '%LCR%'
group by FM_Project__Descriptors_Capital__or__Expense

select Project_Status, count(distinct Project__Insight__Project__ID) ProjectCount
from snp.Project_Information_20210930
where Project_Status in ('Active','Under development') and FM_Project__Descriptors_Project__Type like '%LCR%'
group by Project_Status