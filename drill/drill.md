# Drill

VM for data science
https://github.com/gtkcyber/griffon-vm

## test zoo
~~~
echo stat | nc localhost 2181
~~~


export DRILL_HOME=/opt/drill/drill
$DRILL_HOME/bin/sqlline -u 'jdbc:drill:zk=localhost:2181'



SELECT * FROM sys.drillbits;


http://192.168.121.16:8047

start/stop
~~~
export JAVA_HOME=/opt/sdkman/sdk/candidates/java/current
$DRILL_HOME/bin/drillbit.sh --config /opt/drill/drill/conf start
$DRILL_HOME/bin/drillbit.sh stop
~~~


$DRILL_HOME/bin/sqlline -u 'jdbc:drill:zk=localhost:2181' <<FIN
SELECT * FROM sys.drillbits;
!quit
FIN


$DRILL_HOME/bin/sqlline -u 'jdbc:drill:zk=localhost:2181' -f sc.script


SET `store.format`='parquet';

CREATE TABLE dfs.tmp.sampleparquet AS 
select 
-- this is a comment
    cast( REPORTING_DATE as INT ) REPORTING_DATE,
    cast( SUPPLIER_NAME as
    varchar (256) ) SUPPLIER_NAME,
    cast( CREATION_DATE as TIMESTAMP )
    CREATION_DATE,
    cast( AMOUNT as DECIMAL (14,2) ) AMOUNT,
    cast( DEPARTURE_DATE as
    DATE ) DEPARTURE_DATE,
    cast( RETURN_DATE as DATE ) RETURN_DATE
-- this is the second comment
from 
  table(dfs.`/opt/drill/data/test.sql.csv.gz`(type => 'text',fieldDelimiter => ',', extractHeader => true))
;

select * from dfs.tmp.sampleparquet;





