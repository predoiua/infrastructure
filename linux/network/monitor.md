
## 1. Real Time Network Statistics

~~~ bash
#net
netstat -i   #list network interfaces
ifconfig -s  # or,
nmcli dev    # or,
ip link      # or

watch -n 2 "netstat -tu"   #tu = TCP and UDP statistics

netstat -tulpnc  #c=continous, n=numeric, l=only listening sockets, p=show PID and name of program to which socket belo


lsof -i

iftop -i eth0            # ????
iftop -f "host mail.chrisbinnie.tld and not port smtp"
~~~