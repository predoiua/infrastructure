
## inotify

http://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached

~~~
for foo in /proc/*/fd/*; do readlink -f $foo; done |grep inotify |cut -d/ -f3 |xargs -I '{}' -- ps --no-headers -o '%p %U %c' -p '{}' |uniq -c |sort -nr
~~~


## Enable/disable wireless

~~~bash
rfkill help
rfkill list all
~~~

## Trackpad

~~~bash
xinput
sudo modprobe -r psmouse
sudo modprobe psmouse proto=imps
~~~


## Scriptying

~~~ bash
script_name=`basename $0 .sh`
# -z = length of string is 0
[ -z "$var" ] && var="initial value"

# regex, then after ;
if [[ "abc" == [abc]* ]]; then
    echo "it is true"
fi

~~~
