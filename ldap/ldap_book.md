
# Learn CentOS Linux Network Services
by Antonio Vazquez

## 11 OpenLDAP

### 11.1. Installing OpenLDAP

~~~
yum install openldap openldap-servers openldap-clients
systemctl enable slapd  # result in -> ln -s '/usr/lib/systemd/system/slapd.service' '/etc/systemd/system/multi-user.target.wants/slapd.service'
systemctl start slapd
~~~

### 11.2. Customizing the Installation

~~~
slappasswd                   # generate passwd
ls /etc/openldap/slapd.d/    # files that need to be config, info is store in ldap DB (hdb) !. Edit them with ldapmodify
~~~

#### 11.2.1. Modifying Objects

info store in DB = 
cat /etc/openldap/slapd.d/cn=config/olcDatabase={2}hdb.ldif

LDIF file:
- line 1: dn to operate on:
dn: olcDatabase={2}hdb,cn=config
- line 2: operation
changeType: modify
- line 3: specify that modification is replacement
replace: olcSuffix
- line 4: the new value
olcSuffix: dc=vv10,dc=com

Need to modify at least:
olcSuffix: dc=vv10,dc=com
olcRootDN: cn=Manager,dc=vv10,dc=com

and add entry to store the admin’s password (olcRootPW).

ldapsearch -Y EXTERNAL -H ldapi:/// -b cn=config olcDatabase=\*      # query for config DB

# create modification lddif
~~~
ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: olcDatabase={2}hdb,cn=config
changeType: modify
replace: olcSuffix
olcSuffix: dc=vv10,dc=com
-
replace: olcRootDN
olcRootDN: cn=admin,dc=vv10,dc=com
FIN

ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: olcDatabase={2}hdb,cn=config
changeType: modify
add: olcRootPW
olcRootPW: {SSHA}hV5qwvSqnmsTxH5MpRBuzjouo1lapCmE
FIN
~~~

need to grant access of admin user to DB. see:
cat /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{1\}monitor.ldif

~~~
ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0} to *
  by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read 
  by dn.base="cn=admin,dc=vv10,dc=com" read 
  by * none
FIN
~~~

### 11.3. Securing LDAP Connections with TLS

#### 11.3.1. Creating a CA

~~~
yum info openssl           # check if is installed
cd /etc/pki/CA/            # if it is, this folder exists
touch index.txt            # to keep track of issued certificates
echo 0001 > serial

openssl genrsa -aes256 -out /etc/pki/CA/private/ca.key.pem

openssl req -new -x509 -days 3650 -key /etc/pki/CA/private/ca.key.pem -extensions v3_ca -out /etc/pki/CA/certs/ca.cert.pem

#generate the key and certificate files to use with openldap.
# common name = hostname
openssl genrsa -out private/ldap.vv10.local.key
openssl req -new -key private/ldap.vv10.local.key -out certs/ldap.vv10.local.csr

# sign it
openssl ca -keyfile private/ca.key.pem -cert certs/ca.cert.pem -in certs/ldap.vv10.local.csr -out certs/ldap.vv10.local.crt

# openssl config file
more /etc/pki/tls/openssl.cnf  # set here default values for country, location...

openssl verify -CAfile certs/ca.cert.pem certs/ldap.vv10.local.crt
~~~

#### 11.3.2. Securing the LDAP Protocol

CentOS 7 specific

~~~
/etc/pki/CA/certs/ldap.vv10.local.crt

mkdir -p /etc/openldap/certs/
mkdir -p /etc/openldap/cacerts/

cp /etc/pki/CA/private/ldap.vv10.local.key /etc/openldap/certs/
cp /etc/pki/CA/certs/ldap.vv10.local.crt /etc/openldap/certs/
cp /etc/pki/CA/certs/ca.cert.pem /etc/openldap/cacerts/


slapcat -b "cn=config"            # check default TLS related attributes


ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: cn=config
changetype: modify
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/openldap/certs/ldap.vv10.local.crt
FIN
-
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/openldap/certs/ldap.vv10.local.key
-
replace: olcTLSCACertificatePath
olcTLSCACertificatePath: /etc/openldap/cacerts/ca.cert.pem
FIN
~~~


ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: cn=config
changetype: modify
replace: olcTLSCACertificatePath
olcTLSCACertificatePath: /etc/openldap/cacerts/ca.cert.pem
FIN
