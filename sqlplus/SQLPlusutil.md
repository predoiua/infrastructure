## Enable auto sqlplus initialization

~~~sh
mkdir ~/sqlplus_init
cp login.sql ~/sqlplus_init
cat '
export SQLPATH=~/sqlplus_init
' >> ~/.bash_profile
~~~

## Setings

~~~ SQL
define _editor=vi
set linesize 10000
 -- number of rows per page
set pages 10000
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


