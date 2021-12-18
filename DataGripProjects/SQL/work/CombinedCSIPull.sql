SELECT [DivisionNo]
      ,[SectionNo]
      ,[SubsectionNo]
      ,[SubsectionCategoryNo]
      ,[CSIName]
	  ,CONCAT(DivisionNo, ' ', SectionNo, ' ', SubsectionNo,
		case 
			when SubsectionCategoryNo not like ''
				then CONCAT('.', SubsectionCategoryNo)
		end) CombinedCSI
  FROM [RedmondCR].[dbo].[Dim_CSICodes]
  where CSIName like '%charging%'