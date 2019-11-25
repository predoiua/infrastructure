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

function populate() {
ldapadd -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: dc=vv10,dc=com
objectClass: dcObject
objectClass: organization
dc: vv10
o: vv10
FIN

## Adding an Organizational Unit (OU)

ldapadd -H ldaps:/// -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: ou=users,dc=vv10,dc=com
objectClass: organizationalUnit
ou: users
FIN

## Adding an User to OU

ldapadd -Y EXTERNAL -H ldapi:// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

ldapadd -x -H ldaps:/// -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: cn=Tux,ou=users,dc=vv10,dc=com
cn: Tux
sn: Tuxon
objectClass: inetOrgPerson
userPassword: linuxrules
uid: Tux
FIN

slapcat -b "cn=schema,cn=config"

## Adding a group

ldapadd -H ldaps:/// -x -D cn=admin,dc=vv10,dc=com -w pass <<FIN
dn: cn=bi, ou=users, dc=vv10, dc=com
cn: bi
objectClass: groupOfNames
member: cn=Tux, ou=users, dc=vv10, dc=com
FIN
}