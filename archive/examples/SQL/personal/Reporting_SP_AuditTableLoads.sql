declare @TableName varchar(250)


create table #t
(
	TableName varchar(250),
	RCount int,
	CheckDate datetime,
	AzureLoadDate datetime
)
insert into #t (
		TableName,
		RCount,
		CheckDate
	)
select
		quotename(sOBJ.name)
		, SUM(sPTN.Rows)
		, GETDATE()
from 
		sys.objects AS sOBJ
		inner join sys.partitions AS sPTN
			on sOBJ.object_id = sPTN.object_id
where
		sOBJ.type = 'U'
		and sOBJ.is_ms_shipped = 0x0
		and index_id < 2 -- 0:Heap, 1:Clustered
		and quotename(sOBJ.name) like '%ProjLink%'
group by 
		sOBJ.schema_id
		, sOBJ.name

select @TableName = TableName from #t
print @TableName

drop table #t

exec sp_GetAzureLoadDate @TableName