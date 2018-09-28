
# firwall-cmd

command line interface to netfilter framework.

~~~
firewall-cmd --get-zones        # get all zones
firewall-cmd --list-all         # print configuration
~~~


## Open a tcp port

~~~
firewall-cmd --get-active-zones
firewall-cmd --add-port 389/tcp --permanent 
firewall-cmd --reload
~~~