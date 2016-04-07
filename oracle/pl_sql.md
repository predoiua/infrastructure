
# Interesting PLSQL stuff

## Quote long string

http://stackoverflow.com/questions/11315340/pl-sql-how-to-escape-single-quote-in-a-string

~~~plsql
stmt := q'[insert into MY_TBL (Col) values('ER0002')]';
~~~