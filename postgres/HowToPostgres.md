# Postgres

## With Docker

### Start a new server

~~~bash
docker run --name some-postgres -p 5432:5432 -e POSTGRES_PASSWORD=pass -e POSTGRES_DB=bi -d postgres:9.4
#When done:
docker stop some-postgres
~~~

### Connect to previous started server

~~~bash
docker run -it --link some-postgres:postgres -v ~/tmp/script:/script -v ~/tmp/dump:/dump --rm postgres:9.4 /bin/bash
~~~

A typical set of commands


~~~
psql -h postgres -U postgres
CREATE USER bi WITH SUPERUSER PASSWORD 'bi';
GRANT ALL PRIVILEGES ON DATABASE bi TO bi;

# popuate new DB from a dump
psql -h postgres -U bi
\c bi
\i /dump/bi_2016-02

## or from scripts
psql -h postgres -U postgres
\c bi
\i /bi/bi_schema.sql
\i /bi/bi_data.sql
\q
~~~

## Dump

~~~
#Creat a dump file of "bi" database. it will connect with "postgres" user
pg_dump bi  > bi_2016-02
#Import it or with \i option (better)
psql bi < /dump/bi_2016-02
~~~

## Nice commands

~~~
-- all schemas
\dn
select schema_name from information_schema.schemata

-- all tables
\dt
select * from pg_catalog.pg_tables

-- all table in public schema
\dt public.*
~~~


