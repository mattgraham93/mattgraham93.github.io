/****** Script for SelectTopNRows command from SSMS  ******/
SELECT ExplanationAlphaName,
	ExplanationRemark,
	PKCProjectNUM,
	Amount
  FROM [dbo].[Fact_Build_JDE_GLExport]
  where ([BUSINESSUNIT] like 'MFMCPS' or [BUSINESSUNIT] like 'MFMSPLCR') and 
	([DOTY] = 'JZ' or [DOTY] = 'PZ' or [DOTY] = 'RZ') and ([LT] = 'AZ') 
	and (FY = '20' or FY='21')
	and [PKCProjectNUM] like ''