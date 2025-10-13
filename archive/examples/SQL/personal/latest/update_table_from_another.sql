
	--SELECT adj.[Project ID] AS 'Project ID', 
	--	[SAP Num], 
	--	[Fiscal Period], 
	--	[Amount], 
	--	[Capex/Opex], 
	--	[Asset Class]/*Adjustmets is temp until Aharon adds final column to the upload and SQL Table*/ ,  
	--	'Adjustment' AS 'Transaction Type' ,
	--	'Fact_Build_Adjustments_Final' as 'SourceTable',
	--	[SAP Number]
	--FROM Fact_Build_Adjustments adj
	--	left join VW_FullProjectList fpl
	--		on adj.[Project ID] = fpl.[Project ID]
	--where [SAP Num] is null and adj.[Project ID] is not null;




	--update Fact_Build_Adjustments
	--set [SAP Num] = fpl.[SAP Number]
	--from Fact_Build_Adjustments adj
	--inner join VW_FullProjectList fpl
	--	on adj.[Project ID] = fpl.[Project ID]
	--where [SAP Num] is null and adj.[Project ID] is not null;