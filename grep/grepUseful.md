
# Useful commands

## search in current folder for file containing a substring

~~~sh
#r = recursive
grep -r --include=\*clear.sql partition .
~~~

## split a string in char

~~~sh
#o = print only matching pattern, one per line
echo "abc" | grep -o .
~~~

## find files that contains an exact string

~~~sh
# -r = recursive
# -l = display just file name
# -F = disable regex in pattern
grep -rlF "[Expense].[Expenses]" .
~~~

## remove empty line

~~~
# -v = inverse selectin
# -e = regular expression for pattern matching
cat tmp/main.sql  | grep -v -e '^$' 
~~~

## in place modification

-i flag is not supported by grep
Use:

~~~
grep -v '#delete' demo.sql | sponge demo.sql 
~~~