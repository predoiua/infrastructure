
# Useful 

## set

set -o # show all settings
set +o noclobber; set -o | grep nocl

set -e = exit ( stop )  on error ( !=0 return )
aka: set -o errexit

set -x = for debug. print before execute
aka: set -o xtrace

set -u = stop on env variable not set
aka: set -o nounset
Add ": ${VAR}" at the beginning for variable check
: is a command that does nothing and ingnores its argument. Otherwise string form VAR will try to be executed.
I think the following command is better:

~~~ bash
${parameter:?err_msg}
~~~

# script

## initialize a variable with

http://stackoverflow.com/questions/4437573/bash-assign-default-value

~~~ bash
: ${A:=hello} #is same as A=${A:-hello}
echo $A #=> hello
~~~


## for cycle

~~~bash
for i in {0..5} ; do 
	echo $i ; 
done
~~~

## execute command if some conditions are met

~~~
test -d alim_py || (echo "ERR:Not such folder"; exit 1) && echo "Execute cmd"
~~~

## Execute local script on remote machine

~~~
# -s = everything after it are arguments, not options.
ssh root@machine 'bash -s' < local_script.sh
~~