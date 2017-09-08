# Awk 


## Field separator

~~~
# -F = field separator
# /1/ line patern matching
echo "1: " | awk -F  ":" '/1/ {print $1}'
~~~

## Fix width

~~~
# %-10s = 10 char width
awk '{ printf "%-10s %s\n", $1, $2 }' mail-list
~~~