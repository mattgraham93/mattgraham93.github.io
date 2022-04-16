--create table Dim_QBRCheckIn (
--	CheckInID varchar(15),
--	QBRName varchar(15),
--	QBRDate datetime,
--	FiscalPeriod int,
--	FiscalYear int,
--	AzureLoadDate datetime
--);


-- All Budget LineItemDetails, removing all 0 amounts
with c as 
(select *, 'FY20Q1' QBR from snp.Project_Budget_LineItemDetails_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Budget_LineItemDetails_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Budget_LineItemDetails_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Budget_LineItemDetails_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Budget_LineItemDetails_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Budget_LineItemDetails_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Budget_LineItemDetails_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Budget_LineItemDetails_20210630
)
select * from c where Amount not like '0.0000';

-- All budgets
with c as 
(select *, 'FY20Q1' QBR from snp.Project_Budgets_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Budgets_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Budgets_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Budgets_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Budgets_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Budgets_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Budgets_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Budgets_20210630
)
select * from c;

-- all project commitments
with c as 
(select *, 'FY20Q1' QBR from snp.Project_Commitments_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Commitments_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Commitments_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Commitments_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Commitments_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Commitments_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Commitments_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Commitments_20210630
)
select * from c;

-- all change orders
with c as 
(select *, 'FY20Q1' QBR from snp.Project_Commitments_ChangeOrders_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Commitments_ChangeOrders_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Commitments_ChangeOrders_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Commitments_ChangeOrders_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Commitments_ChangeOrders_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Commitments_ChangeOrders_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Commitments_ChangeOrders_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Commitments_ChangeOrders_20210630
)
select * from c;

-- all commitment line items
with c as 
(select *, 'FY20Q1' QBR from snp.Project_Commitments_LineItemDetails_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Commitments_LineItemDetails_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Commitments_LineItemDetails_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Commitments_LineItemDetails_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Commitments_LineItemDetails_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Commitments_LineItemDetails_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Commitments_LineItemDetails_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Commitments_LineItemDetails_20210630
)
select * from c;

-- all project information

with c as 
(select *, 'FY20Q1' QBR from snp.Project_Information_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Information_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Information_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Information_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Information_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Information_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Information_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Information_20210630
)
select * from c;

-- all project invoices

with c as 
(select *, 'FY20Q1' QBR from snp.Project_Invoices_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Invoices_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Invoices_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Invoices_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Invoices_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Invoices_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Invoices_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Invoices_20210630
)
select * from c;

-- all project milestones
with c as 
(select *, 'FY20Q1' QBR from snp.Project_Milestones_Snapshot20190930
union all
select *, 'FY20Q2' QBR from snp.Project_Milestones_Snapshot20200102
union all
select *, 'FY20Q3' QBR from snp.Project_Milestones_Snapshot20200331
union all
select *, 'FY20Q4' QBR from snp.Project_Milestones_20200630
union all
select *, 'FY21Q1' QBR from snp.Project_Milestones_20200930
union all
select *, 'FY21Q2' QBR from snp.Project_Milestones_20201231
union all
select *, 'FY21Q3' QBR from snp.Project_Milestones_20210331
union all
select *, 'FY21Q4' QBR from snp.Project_Milestones_20210630
)
select * from c;