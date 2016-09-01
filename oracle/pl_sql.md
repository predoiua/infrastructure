
# Interesting PLSQL stuff

## Quote long string

http://stackoverflow.com/questions/11315340/pl-sql-how-to-escape-single-quote-in-a-string

~~~plsql
stmt := q'[insert into MY_TBL (Col) values('ER0002')]';
~~~

## Catch sql error code

~~~plsql
begin
execute immediate q'[
	create table x (
		id number
	) 
]';
exception when others then
      if sqlcode = -955 then null; else raise; end if;
end;
/
~~~
