create procedure sp_Load_BldgInfobyCurrentCL
as 

-- =============================================
-- Author:      Matt Graham, v-magrah
-- Create Date: 01/10/2020
-- Description: Copy data from Stage_BldgInfobyCurrentCL to Fact_BldgInfobyCurrentCL
-- =============================================

insert into Fact_BldgInfobyCurrentCL (
	Building
	,Building_ID
	,[Date]
	,[User]
	,Cell_Value
	,Previous_Value
	,Updated_Value
	,Comments
	) 
select
	Building
	,Building_ID
	,[Date]
	,[User]
	,Cell_Value
	,Previous_Value
	,Updated_Value
	,Comments
from Stage_BldgInfobyCurrentCL

insert into Fact_BldgInfobyCurrentCL(Load_Date) values (GETDATE());

