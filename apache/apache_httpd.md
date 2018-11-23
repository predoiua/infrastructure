
# Apache ssl

On CentOS 7.5

## Generate certificate

as root
~~~
yum install openssl
# generate self signed certificate
#1. Generate private key 
openssl genrsa -out ca.key 2048 

#2. Generate CSR (Certificate Signing Request)
openssl req -new -key ca.key -out ca.csr

#3 Generate Self Signed Key
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

# Copy the files to the correct locations
cp ca.crt /etc/pki/tls/certs
cp ca.key /etc/pki/tls/private/ca.key
cp ca.csr /etc/pki/tls/private/ca.csr
~~~


~~~
yum install mod_ssl
# vi /etc/httpd/conf/httpd.conf

# Redirect http to https
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule (.*) https://%{HTTP_HOST}:443%{REQUEST_URI}


<VirtualHost *:443>
        SSLEngine on
        SSLCertificateFile /etc/pki/tls/certs/ca.crt
        SSLCertificateKeyFile /etc/pki/tls/private/ca.key
        DocumentRoot /var/www/vhosts/yoursite.com/httpsdocs
        ServerName yoursite.com
</VirtualHost>
~~~

