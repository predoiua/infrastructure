#!/bin/bash

function version() {
    cat /etc/centos-release
#CentOS Linux release 7.7.1908 (Core)
    slapd -V
#@(#) $OpenLDAP: slapd 2.4.44 (Jan 29 2019 17:42:45) $
    openssl version
#OpenSSL 1.0.2k-fips  26 Jan 2017
}

# !!! Not OK. is due to root ?
function force_remove() {
    yum -y remove openldap-clients openldap-servers
    rm -rf /etc/openldap/                        ## ??? not sure about certificates
   # rm -rf /etc/openldap/slap.d/
    rm -rf /var/lib/ldap
    userdel ldap
}


function config_host() {
  hostnamectl set-hostname ldap.vv10.com
  echo "127.0.0.1   ldap ldap.vv10 ldap.vv10.com" >>/etc/hosts
  ping -c 1 ldap.vv10.com
}

function install_ldap() {

    yum -y install openldap openldap-clients openldap-servers
    systemctl enable slapd
    systemctl start slapd
    #test it
    ldapsearch -Q -Y EXTERNAL -H ldapi:/// -LLL -b cn=config olcDatabase=\* dn
}


function init_ldap() {

ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: olcDatabase={2}hdb,cn=config
changeType: modify
replace: olcSuffix
olcSuffix: dc=vv10,dc=com
-
replace: olcRootDN
olcRootDN: cn=admin,dc=vv10,dc=com
FIN

PW=$(slappasswd -s pass)

ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: olcDatabase={2}hdb,cn=config
changeType: modify
add: olcRootPW
olcRootPW: ${PW}
FIN
cat /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{2\}hdb.ldif

ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0} to *
  by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read 
  by dn.base="cn=admin,dc=vv10,dc=com" read 
  by * none
FIN
cat /etc/openldap/slapd.d/cn\=config/olcDatabase\=\{1\}monitor.ldif

}

function init_ca() {

  yum info openssl           # check if is installed
  cd /etc/pki/CA/            # if it is, this folder exists
  touch index.txt            # to keep track of issued certificates
  echo 0001 >serial

  openssl genrsa -aes256 -out /etc/pki/CA/private/ca.key.pem
  openssl req -new -x509 -days 3650 -key /etc/pki/CA/private/ca.key.pem -extensions v3_ca -out /etc/pki/CA/certs/ca.cert.pem

  #generate the key and certificate files to use with openldap.
  # common name = hostname
  openssl genrsa -out private/ldap.vv10.local.key
  openssl req -new -key private/ldap.vv10.local.key -out certs/ldap.vv10.local.csr

  # sign it
  openssl ca -keyfile private/ca.key.pem -cert certs/ca.cert.pem -in certs/ldap.vv10.local.csr -out certs/ldap.vv10.local.crt

  # openssl config file
  #more /etc/pki/tls/openssl.cnf  # set here default values for country, location...
  #openssl verify -CAfile certs/ca.cert.pem certs/ldap.vv10.local.crt 
  #openssl verify -CAfile certs/ca.cert.pem certs/ca.cert.pem
  #openssl x509 -in certs/ca.cert.pem -text
  #openssl x509 -in certs/ldap.vv10.local.crt  -text
}

function init_ldaps() {
  mkdir -p /etc/openldap/certs/
  mkdir -p /etc/openldap/cacerts/

  cp /etc/pki/CA/private/ldap.vv10.local.key /etc/openldap/certs/
  cp /etc/pki/CA/certs/ldap.vv10.local.crt /etc/openldap/certs/
  cp /etc/pki/CA/certs/ca.cert.pem /etc/openldap/cacerts/

# !! Re-hash . without it is not recognized
  cacertdir_rehash /etc/openldap/cacerts/
 # cp /etc/pki/CA/certs/ca.cert.pem /etc/pki/ca-trust/source/anchors/ 
 # update-ca-trust

  slapcat -b "cn=schema,cn=config"            # check default TLS related attributes


ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
dn: cn=config
changetype: modify
replace: olcTLSCertificateFile
olcTLSCertificateFile: /etc/openldap/certs/ldap.vv10.local.crt
-
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: /etc/openldap/certs/ldap.vv10.local.key
-
add: olcTLSCACertificateFile
olcTLSCACertificateFile: /etc/openldap/cacerts/ca.cert.pem
-
replace: olcTLSCACertificatePath
olcTLSCACertificatePath: /etc/openldap/cacerts
FIN

cat /etc/openldap/slapd.d/cn\=config.ldif


#vi /etc/sysconfig/slapd
#SLAPD_URLS="ldapi:/// ldap:/// ldaps:///"
systemctl restart slapd
}

function test_slapd() {

  openssl s_client -connect localhost:636
  ldapsearch -x -ZZ
  openssl x509 -in /etc/pki/CA/certs/ldap.vv10.local.crt -noout -text
  ldapsearch -x -H ldaps://ldap.vv10.com:636 -b "dc=vv10,dc=com" "(objectClass=*)" 

  ldapsearch -H ldaps://ldap.vv10.com:636 -D "cn=admin,dc=vv10,dc=com" -w "pass" -b "dc=vv10,dc=com" "(objectClass=*)"

  ldapsearch -H ldaps://ldap.vv10.com:636 -D "cn=Tux,ou=users,dc=vv10,dc=com" -w "linuxrules" -b "dc=vv10,dc=com" "(objectClass=*)"
}

function populate() {
ldapadd -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: dc=vv10,dc=com
objectClass: dcObject
objectClass: organization
dc: vv10
o: vv10
FIN

## Adding an Organizational Unit (OU)

ldapadd -H ldapi:/// -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: ou=users,dc=vv10,dc=com
objectClass: organizationalUnit
ou: users
FIN

## Adding an User to OU

ldapadd -Y EXTERNAL -H ldapi:// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

ldapadd -x -H ldapi:/// -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: cn=Tux,ou=users,dc=vv10,dc=com
cn: Tux
sn: Tuxon
objectClass: inetOrgPerson
userPassword: linuxrules
uid: Tux
FIN

ldapadd -x -H ldapi:/// -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: cn=u1,ou=users,dc=vv10,dc=com
cn: u1
sn: u1
objectClass: inetOrgPerson
userPassword: u1
uid: u1
FIN

ldapadd -x -H ldapi:/// -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: cn=u2,ou=users,dc=vv10,dc=com
cn: u2
sn: u2
objectClass: inetOrgPerson
userPassword: u2
uid: u2
FIN


slapcat -b "cn=schema,cn=config"

## Adding a group

ldapadd -H ldapi:/// -x -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: cn=bi, ou=users, dc=vv10, dc=com
cn: bi
objectClass: groupOfNames
member: cn=Tux, ou=users, dc=vv10, dc=com
member: cn=u1, ou=users, dc=vv10, dc=com
member: cn=u2, ou=users, dc=vv10, dc=com
FIN

#ldapmodify -Y EXTERNAL -H ldapi:/// <<FIN
#dn: cn=bi, ou=users, dc=vv10, dc=com
#changetype: modify
#replace: dn: cn=bi, ou=users, dc=vv10, dc=com
#cn: bi
#objectClass: groupOfNames
#member: cn=Tux, ou=users, dc=vv10, dc=com
#member: cn=u1, ou=users, dc=vv10, dc=com
#member: cn=u2, ou=users, dc=vv10, dc=com
#FIN
}