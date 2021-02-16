/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [RedmondCR].[dbo].[test_msft_rfi_detail] as detail
	inner join Dim_ProjNoAssoc as proj
		on detail.Project = proj.Kahua_BldgProjNo
