create extension ltree;

create table paths_to_nodes (
    id serial primary key,
    node text,
    path ltree
);
create index  idx_paths_to_nodes on  paths_to_nodes using gist (path);


insert into  paths_to_nodes (node, path) values ('A', 'A');
insert into  paths_to_nodes (node, path) values ('B', 'A.B');
insert into  paths_to_nodes (node, path) values ('C', 'A.C');
insert into  paths_to_nodes (node, path) values ('D', 'A.B.D');
insert into  paths_to_nodes (node, path) values ('E', 'A.B.E');
insert into  paths_to_nodes (node, path) values ('F', 'A.C.F');
insert into  paths_to_nodes (node, path) values ('G', 'A.C.G');
insert into  paths_to_nodes (node, path) values ('H', 'A.B.D.H');
insert into  paths_to_nodes (node, path) values ('I', 'A.B.D.I');
insert into  paths_to_nodes (node, path) values ('J', 'A.B.D.J');												 
insert into  paths_to_nodes (node, path) values ('K', 'A.C.F.K');

select * from paths_to_nodes;


select * from paths_to_nodes
where 'A.B' @> path;


select count(*) from paths_to_nodes
where 'A.B' @> path;

Select * from path_to_nodes
Where path ~ ‘*.B.*’;

select * from paths_to_nodes
where path ~ '*.B.*{1}';

select * from paths_to_nodes
where path ~ '*.B.*{0,2}';


select p1.id, p1.node, p1.path
from paths_to_nodes p1
where p1.path ~ '*.B.*';


select * 
from paths_to_nodes p2
where path ~ '*.C.*';



with paths_to_concat as
  (select 
  	 * 
   from 
      paths_to_nodes p2
   where 
      path ~ '*.C.*') 
select 
	p1.id, p1.node, p1.path, p1.path || p2.path
from 
	paths_to_nodes p1,
	paths_to_concat p2;


