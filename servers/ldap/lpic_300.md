
# Practical LPIC-3 300


# 1. Starting with OpenLDAP

object of the types dcObject and organization.
distinguished name (dn), domain component (dc), and organization (o).  

dn: dc=linuxaholics,dc=com
objectClass: dcObject
objectClass: organization
dc: linuxaholics
o: linuxaholics


## Adding an Organizational Unit (OU)

ldapadd -D cn=admin,dc=linuxaholics, dc=com -w pass <<FIN
dn: ou=users,dc=linuxaholics,dc=com
objectClass: organizationalUnit
ou: users
FIN

## Adding an User to OU

ldapadd -Y EXTERNAL -H ldapi:// -f /etc/openldap/schema/cosine.ldif
ldapadd -Y EXTERNAL -H ldapi:/// -f /etc/openldap/schema/inetorgperson.ldif

ldapadd -x -D cn=admin,dc=linuxaholics,dc=com -w pass <<FIN
dn: cn=Tux,ou=users,dc=linuxaholics,dc=com
cn: Tux
sn: Tuxon
objectClass: inetOrgPerson
userPassword: linuxrules
uid: Tux
FIN

slapcat -b "cn=schema,cn=config"

## Adding a group

ldapadd -f groups.ldif -x -D cn=admin,dc=linuxaholics,dc=com -w pass <<FIN
dn: cn=scientists, ou=users, dc=linuxaholics, dc=com
cn: scientists
objectClass: groupOfNames
member: cn=Tux, ou=users, dc=linuxaholics, dc=com
FIN