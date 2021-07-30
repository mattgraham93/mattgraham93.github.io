SELECT BuildingName
      ,DETAILS_Subject
      ,[ATTENDEES_Name]
      ,[ATTENDEES_Company]
      ,[ATTENDEES_Attendance]
  FROM [RedmondCR].[dbo].[test_msft_meeting_attendees]
	inner join Dim_ProjNoAssoc
		on CONCAT('K', Project_Number) = Dim_ProjNoAssoc.Kahua_BldgProjNo
	inner join test_msft_meeting_details
		on test_msft_meeting_attendees.Meeting_Key = test_msft_meeting_details.Meeting_Key
	--inner join test_msft_meeting_items
	--	on test_msft_meeting_details.Meeting_Key = test_msft_meeting_items.Meeting_Key
--where test_msft_meeting_attendees.Project_Number not like '1028812'
--	and test_msft_meeting_attendees.Project_Number not like '1028814'
--	and test_msft_meeting_attendees.Project_Number not like '1028822'
--	and test_msft_meeting_attendees.Project_Number not like '1028813'
--	and test_msft_meeting_attendees.Project_Number not like '1028815'
--	and test_msft_meeting_attendees.Project_Number not like '1028823'
--	and test_msft_meeting_attendees.Project_Number not like '1030118'
--	and test_msft_meeting_attendees.Project_Number not like '1030458'
--	and test_msft_meeting_attendees.Project_Number not like '1021449'