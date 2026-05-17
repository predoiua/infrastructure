# Useful one liner

## Delete some files

~~~ bash
find . -name *~ -delete
# if -delete predicate is not available ...
#   ( notice space between {} and \; )
find . -name *~ -exec rm {} \; 
~~~

## Exclude folder

https://stackoverflow.com/questions/4210042/how-to-exclude-a-directory-in-find-command
to remove ./misc use: -path ./misc -prune -o 

~~~
find . -path ./misc -prune -o -name '*.txt' -print
find . -type d \( -path dir1 -o -path dir2 -o -path dir3 \) -prune -o -print
~~~
