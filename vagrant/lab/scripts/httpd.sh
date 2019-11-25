#!/bin/bash
yum install httpd
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload
echo "Hello world" > /var/www/html/index.html
systemctl enable httpd
systemctl start httpd