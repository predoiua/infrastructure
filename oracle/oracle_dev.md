
# Nice tricks

## Generate a time dimension

~~~ sql
SELECT LEVEL n
FROM dual
CONNECT BY LEVEL <= 100
~~~

## Currency

~~~
with day as (
select to_date('2010-01-01','yyyy-mm-dd') -1 + n day
from dual
    cross join (
        SELECT LEVEL n
        FROM dual
        CONNECT BY LEVEL <= 10000
    )
)
select 
     cur_code, 
     cur_change,
     day
from day
    cross join (
        select cur_code, cur_change
        from  (
            select 'EUR' cur_code, 1 cur_change from dual
        )
    ) cur
where day between to_date('2014-01-01','yyyy-mm-dd') and to_date('2016-08-01','yyyy-mm-dd')
~~~

## Current user

~~~
select sys_context( 'userenv', 'current_schema' ) from dual;
~~~

## Remove passwd expiration date

~~~
select profile from DBA_USERS where username = 'BI';
alter profile DEFAULT limit password_life_time UNLIMITED;
select resource_name,limit from dba_profiles where profile='DEFAULT';
~~~

## Unlock account

ORA-28000: the account is locked

~~~
alter user scott account unlock;
~~~

## ORA-01410 – Invalid rowid

Run in 1st sqlplus session:

~~~ SQL
create table x as select 'a' dummy from all_objects where rownum < 100;


begin
for m in (SELECT * FROM x)
loop
    dbms_output.put_line(m.dummy);
    sys.dbms_lock.sleep(2);
end loop;
end;
/
~~~

Run in 2nd sqlplus session:

~~~ SQL
truncate table x;
insert into x values ( 'b' );
commit;
~~~~

### Using objects

http://stackoverflow.com/questions/1020348/oracle-select-from-record-datatype

~~~sql
create type myobj is object ( 
    id int
    ,name varchar2(10)
);
/

create package mypkg as
    function f return myobj;
end mypkg;
/


create package body mypkg  as
    function f return myobj
    is
    begin
        return myobj(1,'test');
    end f;
end mypkg;
/

select mypkg.f from dual;
/

drop package mypkg;
/

drop type myobj;
/
~~~

### Delete from views

Outer joins can lead to nasty errors. ( Tested in 10 and 11)

~~~sql
drop table x;
create table x(id number);
insert into x values (1);
insert into x values (2);
insert into x values (3);
insert into x values (4);
insert into x values (5);

drop table y;
create table y(id number);
insert into y values (1);
insert into y values (2);

commit;
delete from (
    select x.*
    from x
        left join y on x.id = y.id 
    where x.id is null
);
-- error : ORA-01752: cannot delete from view without exactly one key-preserved table
alter table x add constraint uk_id unique ( id );
-- execute same delete 
-- error : ORA-00600: internal code error

delete from (
    select x.*
    from x
        join y on x.id = y.id 
);
-- rez=>OK

-- we need to delete with something like
delete from x where rowid in (
    select x.rowid
    from x
        left join y on x.id = y.id 
    where y.id is null
);
~~~

### Read sql data from bash

~~~
#!/bin/bash

#exit on error
set -e
#display commands
#set -x
while read -a row
do
        echo "I have:..${row[0]}..${row[1]}..${row[2]}.."
done < <(sqlplus -s scott/tiger << FIN
    set head off;
    set newpage none;
    set feedback off;
    set linesize 1000;
    select sysdate s, 'a' a, 'b' from all_objects where rownum < 5;
    exit;
FIN
)
~~~

### Execute sql commands from bash

~~~bash
#!/bin/bash
set -e

function execute_sql() {
    local p_conn=$1
    local p_sql=$2

    p_sql=${p_sql//old_string/new_string}
    p_res=`sqlplus -s ${p_conn} << FIN 2>&1
        set timing on
        ${p_sql}
        exit;
FIN
`
    echo "${p_res}"
}


function process() {
    local p_sql

    p_sql=$(cat<< FIN
        begin execute immediate 'drop table temp'; exception when others then null; end;
        /
        create table temp (
            row_id urowid
          ,code number
        );

        insert into temp( row_id, code )
        select rowid, 123 code
        from emp
        ;
        commit;

        delete from emp@db_link
        where rowid in ( select row_id from temp );

        commit;
FIN
)
    execute_sql "scott/tiger@orcl" "${p_sql}"

}

process
~~~

### Order : asc = default order

~~~ sql
select * from DBA_DB_LINKS order by CREATED;
--- same as
select * from DBA_DB_LINKS order by CREATED ASC;
~~~

### Operations over DB link restriction

- no DML

### SQL Plus

~~~
WHENEVER SQLERROR EXIT
~~~

## Nice to know views

~~~
-- view source code
SELECT * FROM user_source WHERE TYPE = 'PACKAGE BODY';
-- user functions, procs, packages
SELECT object_name FROM USER_OBJECTS WHERE OBJECT_TYPE IN ('FUNCTION','PROCEDURE','PACKAGE');
-- user tables
select table_name from user_tables;
-- user views
select view_name from user_views;
~~~

## SQLPLUS html

~~~
SET MARKUP HTML ON
spool a.html
~~~

## Rogue queries

http://stackoverflow.com/questions/622289/how-to-check-oracle-database-for-long-running-queries

~~~sqlplus as sys
-- ACTIVE SQL
select S.USERNAME, s.sid, s.osuser, t.sql_id, sql_text
from v$sqltext_with_newlines t
    join V$SESSION s on t.address =s.sql_address and t.hash_value = s.sql_hash_value
where 
  s.status = 'ACTIVE'
  and s.username <> 'SYSTEM'
order by s.sid,t.piece;

-- Long operations
SELECT sid, to_char(start_time,'hh24:mi:ss') stime,  message,( sofar/totalwork)* 100 percent 
FROM v$session_longops
WHERE sofar/totalwork < 1;

-- SQL execution > 60 secs
select s.username, s.sid, s.serial#, s.last_call_et/60 mins_running, q.sql_text
from v$session s
    join v$sqltext_with_newlines q on s.sql_address = q.address
where status='ACTIVE'
  and type <>'BACKGROUND'
  and last_call_et > 60
order by sid,serial#,q.piece
~~~