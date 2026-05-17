

check also ansible/role/apache

~~~
lsof -i | grep http      # check if is running

sestatus                 # check SE Linux status
setenforce 0             # disable it temprary

yum install httpd-manual # install manual : localhost/manual

service httpd restart    # works in CentOS 6 and 7

~~~

Listen 80               # by default on all interfaces
Listen 192.168.50.6:80  # listen only to this internal interface

DocumentRoot /var/www/html  # top-level directory of web site

User apache     # user identity to run as - check file system
Group apache 


Container : 
<Directory/>
<Location/>
<VirtualHost/>
Ex container directive:
    AllowOverride 
    Options
    Order
    Allow form all

## Virtual host

based on "Host" header in browser
multiple DNS point to same IP

Apache config:
~~~
NameVirtualHost *:80 # enable virtual hosting for req on 80
<VirtualHost *.80>
    ServerName east.example.com
    DocumentRoot /var/www/html/east
</VirtualHost>
<VirtualHost *.80>
    ServerName west.example.com
    DocumentRoot /var/www/html/west
</VirtualHost>

~~~