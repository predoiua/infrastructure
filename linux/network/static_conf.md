
# nice TCP related

https://www.tecmint.com/ip-command-examples/

~~~
vi /etc/sysconfig/network-scripts/ifcfg-eth0  # CentOS
vi  /etc/network/interfaces                   # ubuntu
~~~

~~~
ip addr add 192.168.50.5 dev eth1            # set ip to interface
ip addr show                                 # show IP addr
ip addr del 192.168.50.5/24 dev eth1         # remove addr

ip link set eth1 down                        # down/up interface
ip link set eth1 up    

ip route show                                # print route table
ip route add 10.10.20.0/24 via 192.168.50.100 dev eth0 
ip route del 10.10.20.0/24
ip route add default via 192.168.50.100      # add default GW

vi /etc/sysconfig/network-scripts/route-eth0   # permanent route
$ sudo vi /etc/network/interfaces
~~~