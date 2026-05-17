# To Know

## Server administration

### Automatically start Oracle 10g on CentOS 5

~~~bash
1. vi /etc/oratab. At the end should be Y
2. vi $ORACLE_HOME/bin/dbstart
line 78 set ORACLE_HOME_LISTNER=$ORACLE_HOME
3.
> /etc/rc.d/init.d/oracle

echo '#!/bin/bash
# chkconfig: 345 99 10
# description: Oracle auto start-stop script.
case "$1" in
  start)
        su - oracle -c dbstart >> /var/log/oracle
        su - oracle -c "lsnrctl start" >> /var/log/oracle
        ;;
  stop)
        su - oracle -c "lsnrctl stop" >> /var/log/oracle
        su - oracle -c dbshut >> /var/log/oracle
        ;;
  restart)
        su - oracle -c dbshut >> /var/log/oracle
        su - oracle -c dbstart >> /var/log/oracle
        su - oracle -c "lsnrctl stop" >> /var/log/oracle
        su - oracle -c "lsnrctl start" >> /var/log/oracle
        ;;
  *)
        echo "Usage: oracle {start|stop|restart}"
        exit 1
esac
'>> /etc/rc.d/init.d/oracle

chmod 750 /etc/rc.d/init.d/oracle

#chkconfig --add oracle
chkconfig --level 2345 oracle on
chkconfig --list oracle
~~~

### Data Pump folder

~~~sql
SELECT directory_path
FROM dba_directories
WHERE directory_name = 'DATA_PUMP_DIR';
~~~

### Import data with DB pump but change data file location

Tablespaces have to be moved in a distinct step.
I was unable to create both users and tablespaces in same step.

~~~bash
...
remap_datafile=\"/tmp/test01.dbf\":\"/home/oracle/oradata_11g/test01.dbf\"
...
~~~
http://www.dba-oracle.com/t_rman_173_impdp_remap.htm


### Check if an user is connected in Oracle

~~~sql
select s.sid, s.serial#, s.status, p.spid 
from v$session s, v$process p 
where s.username = 'myuser' 
and p.addr (+) = s.paddr;
~~~

### Create DB link

~~~sql
DROP PUBLIC DATABASE LINK remote; 
CREATE PUBLIC DATABASE LINK remote CONNECT TO scott IDENTIFIED BY tiger USING 'remote'; 
~~~

### Modify column data type

~~~sql
alter table table_name
modify ( 
   column_name    varchar2(30)
);
~~~

### Increase process limit

needs DB restart

~~~
show parameter process;
alter system set processes=300 scope=spfile;
alter system set sessions=300 scope=spfile;
~~~

### Charset 

~~~sql
SELECT value$ FROM sys.props$ WHERE name = 'NLS_CHARACTERSET';
SELECT * FROM NLS_DATABASE_PARAMETERS;
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

## Disable account lock on failed login attempt

~~~
SELECT * FROM dba_profiles WHERE PROFILE='DEFAULT' ORDER BY resource_name;
ALTER PROFILE default LIMIT FAILED_LOGIN_ATTEMPTS unlimited;
ALTER PROFILE default LIMIT FAILED_LOGIN_ATTEMPTS 5;
~~~

## Fail to enable "set autotrace on"

~~~
--as sys
@$ORACLE_HOME/sqlplus/admin/plustrce.sql

grant plustrace to scott;

--as scott
@$ORACLE_HOME/rdbms/admin/utlxplan.sql
~~~


## add datafile to tablespace

~~~
SELECT TABLESPACE_NAME, FILE_NAME, AUTOEXTENSIBLE 
FROM DBA_DATA_FILES;

ALTER TABLESPACE  BI
ADD DATAFILE '/vol01/oradata/SID/datafile/bi_2.dbf' 
size 30G;
~~

## add datafile to TEMP tablespace

based on:
http://onlineappsdba.com/index.php/2009/07/27/ora-1652-unable-to-extend-temp-segment-by-128-in-tablespace-temp/

~~~
-- 1. Find tablespace files
select file_name , tablespace_name, t.*
from dba_temp_files t;
-- 2. Find free space
select   
    a.tablespace_name tablespace, 
    d.mb_total,
    sum (a.used_blocks * d.block_size) / 1024 / 1024 mb_used,
    d.mb_total - sum (a.used_blocks * d.block_size) / 1024 / 1024 mb_free
from     v$sort_segment a,
(
  select   b.name, c.block_size, sum (c.bytes) / 1024 / 1024 mb_total
  from     v$tablespace b, v$tempfile c
  where    b.ts#= c.ts#
  group by b.name, c.block_size
  ) d
where    a.tablespace_name = d.name
group by a.tablespace_name, d.mb_total;

-- 3. add new file
alter tablespace temp add tempfile '/u01/app/oracle/oradata/dwh/temp02.db'
  size 30G reuse autoextend on next 1G  maxsize 30G;
-- or reise
alter database tempfile '/u01/app/oracle/oradata/dwh/temp01.dbf' resize 3072m;

-- why
-- Usage per statement
select  s.sid || ',' || s.serial# sid_serial, s.username, q.hash_value, q.sql_text,
        t.blocks * tbs.block_size / 1024 / 1024 mb_used, t.tablespace
from    v$sort_usage t,
        v$session s,
        v$sqlarea q,
        dba_tablespaces tbs
where   t.session_addr = s.saddr
      and     t.sqladdr = q.address
      and     t.tablespace = tbs.tablespace_name
order by mb_used;

-- Usage per session
select 
  s.sid || ',' || s.serial# sid_serial, s.username, s.osuser, p.spid, s.module,
  p.program, sum (t.blocks) * tbs.block_size / 1024 / 1024 mb_used, t.tablespace,
  count(*) statements
from     v$sort_usage t, 
         v$session s,
         dba_tablespaces tbs,
         v$process p
where    t.session_addr = s.saddr
    and  s.paddr = p.addr
    and  t.tablespace = tbs.tablespace_name
group by s.sid, s.serial#, s.username, s.osuser, p.spid, s.module,
    p.program, tbs.block_size, t.tablespace
order by mb_used;

~~~


## Clear cache

~~~
alter system set events 'immediate trace name flush_cache';
alter system flush shared_pool;
~~

## Revoke DBA role from user

~~~
select * from dba_role_privs where granted_role='DBA';
revoke dba from XXX;
~~~

## Free space in tablespace

~~~
select
   fs.tablespace_name                          "Tablespace",
   (df.totalspace - fs.freespace)              "Used MB",
   fs.freespace                                "Free MB",
   df.totalspace                               "Total MB",
   round(100 * (fs.freespace / df.totalspace)) "Pct. Free"
from
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) TotalSpace
   from
      dba_data_files
   group by
      tablespace_name
   ) df,
   (select
      tablespace_name,
      round(sum(bytes) / 1048576) FreeSpace
   from
      dba_free_space
   group by
      tablespace_name
   ) fs
where
   df.tablespace_name = fs.tablespace_name;
~~~