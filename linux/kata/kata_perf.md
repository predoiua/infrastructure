
## 1. Real­Time Network Statistics

~~~ bash
#net
#list network interfaces
netstat -i
#same as
ifconfig -s

#tu = TCP and UDP statistics
watch -n 2 "netstat tu"

#c continous
#n numeritc
#l show only listening sockets
#p show PID and name of program to which socket belong
netstat -tulpnc

lsof -i

iftop -i eth0
iftop-f "host mail.chrisbinnie.tld and not port smtp"
~~~