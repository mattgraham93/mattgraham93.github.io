--Review meeting all items, associated with each meeting
select *
from test_msft_meeting_items as items
	inner join test_msft_meeting_details as details
		on items.Meeting_Key = details.Meeting_Key
	inner join Dim_ProjNoAssoc as proj
		on CONCAT('K', items.Project_Number) = proj.Kahua_BldgProjNo
--where items.Project_Number not like '1028812'
--	and items.Project_Number not like '1028814'
--	and items.Project_Number not like '1028822'
--	and items.Project_Number not like '1028813'
--	and items.Project_Number not like '1028815'
--	and items.Project_Number not like '1028823'
--	and items.Project_Number not like '1030118'
--	and items.Project_Number not like '1030458'
--	and items.Project_Number not like '1021449'