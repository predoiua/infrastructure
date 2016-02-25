
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

