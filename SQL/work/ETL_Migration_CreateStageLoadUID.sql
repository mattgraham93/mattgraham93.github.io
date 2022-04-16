create table Stage_Build_ResourcePlanning(
	ResourceTitle varchar(50),
	EmployeeName varchar(75),
	ProjectID varchar(50),
	WorkHrsPerMo int,
	FiscalPeriod varchar(10),
	PercentWorkHrs decimal(5,2),
	NumWorkHrs decimal(7,2),
	ShopRate decimal(9,2),
	CostWorkHrs decimal(18,2)
)

create table Fact_Build_ResourcePlanning(
	ResourceTitle varchar(50),
	EmployeeName varchar(75),
	ProjectID varchar(50),
	WorkHrsPerMo int,
	FiscalPeriod varchar(10),
	PercentWorkHrs decimal(5,2),
	NumWorkHrs decimal(7,2),
	ShopRate decimal(9,2),
	CostWorkHrs decimal(18,2),
	AzureLoadDate datetime
)
create unique index idx_Fact_ProjectRP
on Fact_Build_ResourcePlanning(ProjectID, FiscalPeriod);

select * from Fact_Build_ResourcePlanning rp
join sys.indexes ix
	on ix.object_id = rp.object_id and ix.index_id = rp.index_id
	where ix.name = 'idx_Fact_ProjectRP'