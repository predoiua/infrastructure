# Awk 

## Field separator

~~~
echo "1: " | awk -F  ":" '/1/ {print $1}'         # -F = field separator # /1/ line patern matching
~~~

## Fix width

~~~
awk '{ printf "%-10s %s\n", $1, $2 }' mail-list    # %-10s = 10 char width
~~~