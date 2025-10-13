select cast(DateUpdated as date) from Stage_Build_JDE_GLExport
where CAST(dateupdated as date) > '2021-01-01'
order by 1

delete from Test_Build_JDE_GLExport
where cast(dateupdated as date) > '2021-06-14'

select st.* from
Stage_Build_JDE_GLExport st
group by dateupdated
having max(cast(dateupdated as date)) > (select max(cast(dateupdated as date)) from Test_Build_JDE_GLExport)

select * from
Test_Build_JDE_GLExport
where cast(dateupdated as date) > '2021-06-14'
	

select top (1000) * from
Stage_Build_JDE_GLExport
where cast(dateupdated as date) > '2021-06-14'


insert into Test_Build_JDE_GLExport
select * from
Stage_Build_JDE_GLExport
where cast(dateupdated as date) < '2021-06-14'

select * from Test_Build_JDE_GLExport
where cast(dateupdated as date) > '2021-06-14'


insert into Test_Build_JDE_GLExport
select *
from Stage_Build_JDE_GLExport st
where not exists 
	(select *
	from Test_Build_JDE_GLExport ft
	where st.JDERID = ft.JDERID)