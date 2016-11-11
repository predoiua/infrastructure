
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

## All user env

For oracle SID, SCHEMA..

http://stackoverflow.com/questions/8114453/read-all-parameters-from-sys-context-userenv

~~~
   select res.*
    from (
      select *
      from (
        select
          sys_context ('userenv','ACTION') ACTION,
          sys_context ('userenv','AUDITED_CURSORID') AUDITED_CURSORID,
          sys_context ('userenv','AUTHENTICATED_IDENTITY') AUTHENTICATED_IDENTITY,
          sys_context ('userenv','AUTHENTICATION_DATA') AUTHENTICATION_DATA,
          sys_context ('userenv','AUTHENTICATION_METHOD') AUTHENTICATION_METHOD,
          sys_context ('userenv','BG_JOB_ID') BG_JOB_ID,
          sys_context ('userenv','CLIENT_IDENTIFIER') CLIENT_IDENTIFIER,
          sys_context ('userenv','CLIENT_INFO') CLIENT_INFO,
          sys_context ('userenv','CURRENT_BIND') CURRENT_BIND,
          sys_context ('userenv','CURRENT_EDITION_ID') CURRENT_EDITION_ID,
          sys_context ('userenv','CURRENT_EDITION_NAME') CURRENT_EDITION_NAME,
          sys_context ('userenv','CURRENT_SCHEMA') CURRENT_SCHEMA,
          sys_context ('userenv','CURRENT_SCHEMAID') CURRENT_SCHEMAID,
          sys_context ('userenv','CURRENT_SQL') CURRENT_SQL,
          sys_context ('userenv','CURRENT_SQLn') CURRENT_SQLn,
          sys_context ('userenv','CURRENT_SQL_LENGTH') CURRENT_SQL_LENGTH,
          sys_context ('userenv','CURRENT_USER') CURRENT_USER,
          sys_context ('userenv','CURRENT_USERID') CURRENT_USERID,
          sys_context ('userenv','DATABASE_ROLE') DATABASE_ROLE,
          sys_context ('userenv','DB_DOMAIN') DB_DOMAIN,
          sys_context ('userenv','DB_NAME') DB_NAME,
          sys_context ('userenv','DB_UNIQUE_NAME') DB_UNIQUE_NAME,
          sys_context ('userenv','DBLINK_INFO') DBLINK_INFO,
          sys_context ('userenv','ENTRYID') ENTRYID,
          sys_context ('userenv','ENTERPRISE_IDENTITY') ENTERPRISE_IDENTITY,
          sys_context ('userenv','FG_JOB_ID') FG_JOB_ID,
          sys_context ('userenv','GLOBAL_CONTEXT_MEMORY') GLOBAL_CONTEXT_MEMORY,
          sys_context ('userenv','GLOBAL_UID') GLOBAL_UID,
          sys_context ('userenv','HOST') HOST,
          sys_context ('userenv','IDENTIFICATION_TYPE') IDENTIFICATION_TYPE,
          sys_context ('userenv','INSTANCE') INSTANCE,
          sys_context ('userenv','INSTANCE_NAME') INSTANCE_NAME,
          sys_context ('userenv','IP_ADDRESS') IP_ADDRESS,
          sys_context ('userenv','ISDBA') ISDBA,
          sys_context ('userenv','LANG') LANG,
          sys_context ('userenv','LANGUAGE') LANGUAGE,
          sys_context ('userenv','MODULE') MODULE,
          sys_context ('userenv','NETWORK_PROTOCOL') NETWORK_PROTOCOL,
          sys_context ('userenv','NLS_CALENDAR') NLS_CALENDAR,
          sys_context ('userenv','NLS_CURRENCY') NLS_CURRENCY,
          sys_context ('userenv','NLS_DATE_FORMAT') NLS_DATE_FORMAT,
          sys_context ('userenv','NLS_DATE_LANGUAGE') NLS_DATE_LANGUAGE,
          sys_context ('userenv','NLS_SORT') NLS_SORT,
          sys_context ('userenv','NLS_TERRITORY') NLS_TERRITORY,
          sys_context ('userenv','OS_USER') OS_USER,
          sys_context ('userenv','POLICY_INVOKER') POLICY_INVOKER,
          sys_context ('userenv','PROXY_ENTERPRISE_IDENTITY') PROXY_ENTERPRISE_IDENTITY,
          sys_context ('userenv','PROXY_USER') PROXY_USER,
          sys_context ('userenv','PROXY_USERID') PROXY_USERID,
          sys_context ('userenv','SERVER_HOST') SERVER_HOST,
          sys_context ('userenv','SERVICE_NAME') SERVICE_NAME,
          sys_context ('userenv','SESSION_EDITION_ID') SESSION_EDITION_ID,
          sys_context ('userenv','SESSION_EDITION_NAME') SESSION_EDITION_NAME,
          sys_context ('userenv','SESSION_USER') SESSION_USER,
          sys_context ('userenv','SESSION_USERID') SESSION_USERID,
          sys_context ('userenv','SESSIONID') SESSIONID,
          sys_context ('userenv','SID') SID,
          sys_context ('userenv','STATEMENTID') STATEMENTID,
          sys_context ('userenv','TERMINAL') TERMINAL
        from dual
        -- where sys_context ('userenv','SESSIONID') NOT in ('SYS', 'XDB')    -- <<<<< filter by user
      )
      unpivot include nulls (
        val for name in (action, audited_cursorid, authenticated_identity, authentication_data, authentication_method, bg_job_id, client_identifier, client_info, current_bind, current_edition_id, current_edition_name, current_schema, current_schemaid, current_sql, current_sqln, current_sql_length, current_user, current_userid, database_role, db_domain, db_name, db_unique_name, dblink_info, entryid, enterprise_identity, fg_job_id, global_context_memory, global_uid, host, identification_type, instance, instance_name, ip_address, isdba, lang, language, module, network_protocol, nls_calendar, nls_currency, nls_date_format, nls_date_language, nls_sort, nls_territory, os_user, policy_invoker, proxy_enterprise_identity, proxy_user, proxy_userid, server_host, service_name, session_edition_id, session_edition_name, session_user, session_userid, sessionid, sid, statementid, terminal)
      )
    ) res;
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