


## Scripting

~~~ bash
script_name=`basename $0 .sh`
# -z = length of string is 0
[ -z "$var" ] && var="initial value"

# regex, then after ;
if [[ "abc" == [abc]* ]]; then
    echo "it is true"
fi
~~~



## 1.Hello world

~~~bash
pwd
echo "${PWD}"
echo "$HOME"
>test
type -a test
~~~

~~~bash
#!/bin/bash
printf "%s\n%03d" "Hello, World!" 16
~~~

## 2.Input, Output, and Throughput
