
# Open LDAP


This tutorial is for Open LDAP 2.4.50 on Cent OS 6.6/7.1/
Configuration method used :
RTC method (Real Time Configuration) = the cn=config method

This is the newer version of configuration ( slapd.conf is obsolete ).

## Install

~~~
sudo yum -y install openldap openldap-clients openldap-servers
sudo ls /etc/openldap/
~~~

## Un install (if someting goes wrong)

~~~
sudo yum -y remove openldap-clients openldap-servers
sudo rm -rf /etc/openldap/
sudo rm -rf /var/lib/ldap/*
~~~

Start it
~~~
sudo systemctl start slapd.service
#or
sudo service slapd stop
sudo service slapd start
~~~

Test to see if is running

~~~
sudo ldapsearch         -Y EXTERNAL -H ldapi:/// -b cn=config
sudo ldapsearch -Q -LLL -Y EXTERNAL -H ldapi:/// -b cn=config dn
~~~

Load some missing schema in LDAP

~~~
#sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/core.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/cosine.ldif
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif
~~~

-  one of the databases is the configuration database itself. 
it is cn=config () That is: Common Name = "config" )
- Database configuration objects have the objectClass: olcDatabase. 
- the user databases are indicated by the data storage back end (bdb|hdb)

~~~
# Find olcDatabase number
sudo ldapsearch -Q -Y EXTERNAL -H ldapi:/// -LLL -b cn=config olcDatabase=\* dn   # search cn= .. with field olcDatabase and print dn
# Show admin, root dn in that db.
sudo ldapsearch -Q -Y EXTERNAL -H ldapi:/// -LLL -b cn=config 'olcDatabase={2}hdb' 
~~~

## Version 1

~~~
#Set the Database Suffix
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// <<EOF
dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: dc=example,dc=com
EOF

#Root DN
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// <<EOF
dn: olcDatabase={2}hdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: cn=Manager,dc=example,dc=com
EOF

#Password
sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// <<EOF
dn: olcDatabase={2}hdb,cn=config
changetype: modify
add: olcRootPW
olcRootPW: secret
EOF
~~~

## Version 2

Configure it

~~~
cp /usr/share/openldap-servers/slapd.ldif ~
vi ~/slapd.ldif
~~~

Delete everything beside "# Backend database definitions"
and set: (xx are your values, secret is LDAP password)
~~~
olcSuffix: xx
olcRootDN: xx
olcRootPW: secret
~~~

Load it in LDAP

~~~
sudo ldapadd -Y EXTERNAL -H ldapi:/// -f ~/slapd.ldif
~~~

See what was added:
~~~
sudo ls -t1 /etc/openldap/slapd.d/cn=config/ | head -1
~~~



## Good sources

http://electron-swamp.blogspot.ro/2014/04/initializing-openldap-database-with.html

http://www.zytrax.com/books/ldap/