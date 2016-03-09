
## inotify

http://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached

~~~
for foo in /proc/*/fd/*; do readlink -f $foo; done |grep inotify |cut -d/ -f3 |xargs -I '{}' -- ps --no-headers -o '%p %U %c' -p '{}' |uniq -c |sort -nr
~~~