SELECT ai.[Project_Key]
      ,ai.[Project_Number]
      ,ai.[Meeting_Key]
      ,ai.[Meeting_Item_Key]
      ,ai.[Action_Item_Key]
      ,ai.[ACTION_ITEMS_Subject]
      ,ai.[ACTION_ITEMS_Assigned_To_NAME]
      ,ai.[ACTION_ITEMS_Due_Date]
      ,ai.[Action_ITEMS_Status]
	  --,md.DETAILS_Subject
	  --,mi.MEETING_ITEMS_Subject
  FROM [RedmondCR].[dbo].[test_msft_meeting_ActionItem] as ai
	--inner join test_msft_meeting_details as md
	--	on ai.Meeting_Key = md.Meeting_Key
	--inner join test_msft_meeting_items as mi
	--	on ai.Meeting_Item_Key = mi.Meeting_Item_Key
	inner join Dim_ProjNoAssoc as proj
		on CONCAT('K', ai.Project_Number) = proj.Kahua_BldgProjNo 
--where ai.Project_Number not like '1028812'
--	and ai.Project_Number not like '1028814'
--	and ai.Project_Number not like '1028822'
--	and ai.Project_Number not like '1028813'
--	and ai.Project_Number not like '1028815'
--	and ai.Project_Number not like '1028823'
--	and ai.Project_Number not like '1030118'
--	and ai.Project_Number not like '1030458'
--	and ai.Project_Number not like '1021449'