## Enable auto sqlplus initialization

~~~sh
export SQLPATH=~/sqlplus_init

vi ${SQLPATH}/login.sql
~~~

## Setings

~~~ SQL
define _editor=vi
set linesize 10000
 -- number of rows per page
set pages 10000
set serveroutput on
set timing on
~~~

## call options

~~~bash
#silent = supress command prompt, command echo, banner
sqlplus -s
~~~


## Exit on error

~~~sql
WHENEVER SQLERROR EXIT SQL.SQLCODE
~~~

## NSL

~~~bash
export NLS_LANG="FRENCH_FRANCE.WE8MSWIN1252"
~~~

~~~sqlplus
alter session set NLS_LANGUAGE=FRENCH;
alter session set NLS_TERRITORY=FRANCE;
~~~

## HTML spool

~~~
SET MARKUP HTML ON SPOOL ON
spool a.html
select * from dual;
SET MARKUP HTML OFF SPOOL OFF
~~~