
# Useful commands

- search in current folder for file containing a substring

~~~sh
#r = recursive
grep -r --include=\*clear.sql partition .
~~~

- split a string in char

~~~sh
#o = print only matching pattern, one per line
echo "abc" | grep -o .
~~~

- find files that contains an exact string

~~~sh
# -r = recursive
# -l = display just file name
# -F = disable regex in pattern
grep -rlF "[Expense].[Expenses]" .
~~~
