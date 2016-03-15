create table h (
	id number
	,id_parent number
	,name varchar2(20)
);

truncate table h;
insert into h values (1, null, 'top');
insert into h values (2, 1, '2.1');
insert into h values (3, 1, '3.1');
insert into h values (4, 3, '4.3');
insert into h values (5, 3, '5.3');
insert into h values (6, 5, '6.5');
insert into h values (22, 1, '22.1');

-- all childs with parent = 3
select *
from h
start with id = 3
connect by prior id = id_parent;

-- all parents for child = 5
with recursive (id, id_parent) as (
	select child.id, child.id_parent
	from h child
	where child.id = 5
	union all
	select h.id, h.id_parent
	from recursive r
		join h on h.id = r.id_parent
)
select id, id_parent
from recursive;

-- usage
with recursive (id, id_parent, lvl) as (
	select child.id, child.id_parent, 1 lvl
	from h child
	where child.id = 5
	union all
	select h.id, h.id_parent, lvl + 1
	from recursive r
		join h on h.id = r.id_parent
)
select r.id, r.id_parent, h.*
from recursive r
	join h on r.id = h.id;


/*
For better model see nested tree model- using left, rigth on each row
http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
*/