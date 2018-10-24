
# Apache ssl

On CentOS 7.5

## Generate certificate

~~~
yum install mod_ssl openssl
# generate self signed certificate
#1. Generate private key 
openssl genrsa -out ca.key 2048 

#2. Generate CSR (Certificate Signing Request)
openssl req -new -key ca.key -out ca.csr

#3 Generate Self Signed Key
openssl x509 -req -days 365 -in ca.csr -signkey ca.key -out ca.crt

# Copy the files to the correct locations
sudo cp ca.crt /etc/pki/tls/certs
sudo cp ca.key /etc/pki/tls/private/ca.key
sudo cp ca.csr /etc/pki/tls/private/ca.csr

~~~


~~~
LoadModule ssl_module modules/mod_ssl.so

Listen 443
<VirtualHost *:443>
    ServerName www.example.com
    SSLEngine on
    SSLCertificateFile /path/to/www.example.com.cert
    SSLCertificateKeyFile /path/to/www.example.com.key
</VirtualHost>
~~~

