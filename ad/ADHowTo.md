
# 1.Introduction 

- NT "domain” concept was introduced =  a way to group resources based on administrative and security boundaries
- Each entry is referred to as an object. there are two types of objects: containers and non-containers.
- User, group, and computer objects are actually containers
- Although the data in Active Directory is presented hierarchically, it is actually stored in flat database rows and columns.
- The most common type of container you will create in Active Directory is an organizational unit (OU)
- objects have a globally unique identifier (GUID) assigned to them by the system at creation. This 128-bit number is
the Microsoft implementation of the universally unique identifier (UUID).
- GUID is resilient, it is not very easy to remember, nor is it based on the directory hierarchy. For that reason, another way to reference objects, called a distinguished name (DN), is more commonly used.
- DN = Distinguished names are defined in the LDAP standard as a means of referring to any object in the directory.
eg. dc=mydomain,dc=mycorp,dc=com
- DC = domain component
- RDN =  relative distinguished name
eg. DC cn=Administrator,cn=Users,dc=mycorp,dc=com
RDN cn=Administrator

CN  Common name
L   Locality name
ST  State or province name
O   Organization name
OU  Organizational unit name
C   Country name
STREET Street address
DC  Domain component
UID User ID

# 2. Fundamentals

Active Directory domain is made up of the following components:
• An X.500-based hierarchical structure of containers and objects
• A DNS domain name as a unique identifier
• A security service, which authenticates and authorizes any access to resources via accounts in the domain or trusts with other domains
• Policies that dictate how functionality is restricted for users or machines within that domain

large-scale (domains, trees, and forests)
	DC = A domain controller (DC) can be authoritative for one and only one domain
	domain tree = a collection ofdomains
	forest = a collection of one or more domain trees.

small-scale
Organizational Units

GC = Global Catalog (GC) = it is used to perform forest-wide searches.It is a catalog of all objects in a forest that contains a subset of attributes for each object
GC can be accessed via LDAP over port 3268 or LDAP/SSL over port 3269
The attributes that are available in the Global Catalog are members of the partial attribute set (PAS).



SID = What’s in a Security Identifier (SID)
S-v-id-s1-s2-s3-s4-s5-s6-s7-s8-s9-s10-s11-s12-s13-s14-s15
v = 1 = version of the SID structure.
id =  is called the identifier authority. NULL (0), World (1), Local (2), NT Authority (5), etc.
The next 15 fields ( s1 – s15 ) are not required for every SID = sub-authorities
The last sub-authority = the value that a domain or computer increments to create unique SIDs.
S-1-5-10 = NT Authority\Self
S-1-1-0 = Everyone.




## Alfresco

Comezile de mai jos se ruleaza cu user LSA cu drepturi in AD (IT Sec)
LSA = Local Security Authority 

User Logon Name:
HTTP/app1.vv10.biz    @VV10.BIZ
User logon (pre 200)
VV10\  NPA1



~~~
ktpass -princ HTTP/HTTP/app1.vv10.biz@VV10.BIZ -pass "password" -mapuser VV10\NPAAACAPP6030 -crypto all -ptype KRB5_NT_PRINCIPAL -out c:\etc\http_app1.keytab -kvno 0

Create the Service Principal Names (SPN) for the account using the setspn utility (de adaugat si viitorul nume de dns).
setspn -a HTTP/app1 NPA1
setspn -a HTTP/app1.vv10.biz NPAAACAPP6030


a. Set up the Kerberos ini file to point to the Windows domain controller.
The default location is %WINDIR%\krb5.ini, where %WINDIR% is the location of your Windows directory, for example, C:\Windows\krb5.ini. 
If the file does not already exist (for example, if the Kerberos libraries are not installed on the target server), you must copy these over or create them from scratch. 
See Kerberos Help for more information on the krb5.conf file. In this example, our Windows domain controller host name is adsrv.alfresco.org.
[libdefaults]
default_realm = VV10.BIZ
default_tkt_enctypes = rc4-hmac
default_tgs_enctypes = rc4-hmac 

[realms]
VV10.BIZ = {
kdc = srpafinf0011.insim.biz
kdc = srpafinf0012.insim.biz
admin_server = srpafinf0011.insim.biz
}
[domain_realm]
app1.vv10.biz = VV10.BIZ
.app1.vv10.biz = VV10.BIZ

Note:Specify the realm in uppercase.
