
netfilter = kernel filtering subsystem.
To interact with netfilter = write kernel module or use other programs ( eg. iptables )
iptables only for IPv4. ip6tales, ebtables for soft briges

firewalld interface to iptables ( rhel 7) or nftables ( rhel 8 ).

~~~
ls /usr/lib/firewalld/       # firewalld configuration folder
~~~

Configure firewall settings

1. edit config files in /etc/firewalld
2. firewall-config tool. graphical tool
3. firewall-cmd command line

example

~~~
firewall-cmd --set-default-zone=dmz
firewall-cmd --permanent --zone=internal --add-service=192.168.0.0/24
firewall-cmd --permanent --zone=internal --add-service=mysql
firewall-cmd --reload
~~~

lab - limiting network communication

on serrverX = web server listening to 80/tcp ans ssl 443/tcp. allow only ssl connection

~~~
sudo yum -y install httpd mod_ssl   # web server + extension for ssl
sudo bash -c "echo 'I am alive' >>/var/www/html/index.html"
sudo systemctl start httpd
sudo systemctl enable httpd
# make sure iptables and ip6tables is maked and firewalld is enabled and running
sudo systemctl mask iptables ip6tables
sudo systemctl status firewalld
firewall-config  # change to permanent, add https, remove http, options->reload
# check
curl -k http://192.168.10.180      # blocked
curl -k https://192.168.10.180     # OK

# check setting
firewall-cmd --get-default-zone
firewall-cmd --set-default-zone public
firewall-cmd --permanent --zone=public --list-all
firewall-cmd --permanent --zone=public --add-service http
firewall-cmd --reload

~~~