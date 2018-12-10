firewall-cmd --permanent --change-interface=eth0 --zone=external
firewall-cmd --permanent --change-interface=eth1 --zone=internal
firewall-cmd --permanent --change-interface=eth2 --zone=internal

firewall-cmd --permanent --zone=external --add-masquerade

firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -s 192.168.1.0/24 -j ACCEPT
firewall-cmd --permanent --direct --add-rule ipv4 filter FORWARD 0 -s 192.168.2.0/25 -j ACCEPT

systemctl reload firewalld
