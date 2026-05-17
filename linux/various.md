## Can not overwrite file

~~~
set -o noclobber
~~~

## inotify

http://unix.stackexchange.com/questions/13751/kernel-inotify-watch-limit-reached

~~~
for foo in /proc/*/fd/*; do readlink -f $foo; done |grep inotify |cut -d/ -f3 |xargs -I '{}' -- ps --no-headers -o '%p %U %c' -p '{}' |uniq -c |sort -nr
~~~

increase it :

~~~
#temporary
sudo sysctl fs.inotify.max_user_watches=16384
#permanent
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
~~~

## Enable/disable wireless

~~~bash
rfkill help
rfkill list all
~~~

## Disable IPv6

~~~
vi /etc/sysctl.conf
# add 
# IPv6 disabled
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1

sudo sysctl -p               # restart , maybe sysctl --load=/etc/sysctl.conf
~~~

## Trackpad

~~~bash
xinput
sudo modprobe -r psmouse
sudo modprobe psmouse proto=imps
~~~

## DHCP Client

Check if/how DHCP is configured on Debian

~~~ bash
cat /etc/network/interfaces    #Check existing interfaces and if they have dhcp
ls -lrt /var/lib/dhcp/         #Check details : IP, lease time...
cat /var/lib/dhcp/dhclient.eth0.leases
~~~


