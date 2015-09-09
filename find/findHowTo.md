#Useful one liner

- Delete some files

~~~ bash
find . -name *~ -delete
# if -delete predicate is not available ...
#   ( notice space between {} and \; )
find . -name *~ -exec rm {} \; 
~~~
