---
layout: post
date:   2015-10-13 22:00:00
categories: oracle
---
* toc
{:toc}

# Oracle 10g R2 clean on CentOS 5.5


## Install required software

http://www.idevelopment.info/data/Oracle/DBA_tips/Linux/LINUX_15.shtml

pirut-> Package manager

pup -> Package updater

~~~
Install:
Desktop Environments
    GNOME Desktop Environment
Applications
    Editors
    Graphical Internet
    Text-based Internet
Development
    Development Libraries
    Development Tools
    Legacy Software Development
Servers
    Server Configuration Tools
Base System
    Administration Tools
    Base
    Java
    Legacy Software Support
    System Tools
    X Window System
###################

or
( Where is Java group ?)
yum grouplist
~~~

~~~bash
cat <<FIN |
    GNOME Desktop Environment
    Editors
    Graphical Internet
    Text-based Internet
    Development Libraries
    Development Tools
    Legacy Software Development
    Server Configuration Tools
    Administration Tools
    Base
    Legacy Software Support
    System Tools
    X Window System
FIN
while read pack; do
    echo yum groupinstall "${pack}" -y
done

yum groupinfo "Base" | less
~~~

##Configure local machine

~~~bash
###### as root ##########
groupadd oinstall
groupadd dba
groupadd oracle
useradd -g oinstall -G dba oracle
passwd oracle
#useradd nobody
#usermod -a -G vboxsf oracle

echo "
kernel.shmall = 2097152
kernel.shmmax = 2147483648
kernel.shmmni = 4096
kernel.sem = 250 32000 100 128
fs.file-max = 65536
net.ipv4.ip_local_port_range = 1024 65000
net.core.rmem_default = 262144
net.core.rmem_max = 262144
net.core.wmem_default = 262144
net.core.wmem_max = 262144
" >> /etc/sysctl.conf
vi /etc/sysctl.conf

sysctl -p /etc/sysctl.conf

echo "
oracle soft nproc 2047
oracle hard nproc 16384
oracle soft nofile 1024
oracle hard nofile 65536
" >> /etc/security/limits.conf
vi /etc/security/limits.conf

echo "
session required pam_limits.so
" >>/etc/pam.d/login
vi /etc/pam.d/login

echo '
if [ $USER = "oracle" ]; then
    if [ $SHELL = "/bin/ksh" ]; then
        ulimit -p 16384
        ulimit -n 65536
    else
        ulimit -u 16384 -n 65536
    fi
fi
' >> /etc/profile
vi /etc/profile

echo redhat-4 >>  /etc/redhat-release
## !!!! rpm -qa --queryformat "%{NAME}-%{VERSION}-%{RELEASE} (%{ARCH})\n"| grep libXp
## pirut -> search libXp -> install all of them
~~~~

## Install Oracle software

~~~bash
###### as oracle #########
mkdir -p /home/oracle/oracle/product/10.2.0/db_2
#chown -R oracle:oinstall /home/oracle/oracle/product/10.2.0/db_2
chmod -R 775 /home/oracle/oracle/product/10.2.0/db_2

#export ORACLE_HOME=/home/oracle/oracle/product/10.2.0/db_2
#mount -o uid=501,gid=501 -o umask=022 -t vboxsf kit_oracle /home/oracle/kit

runInstall
~~~

## Configure, install DB

~~~bash
###### as root #########
run as root:
/home/oracle/oraInventory/orainstRoot.sh
/home/oracle/oracle/product/10.2.0/db_1/root.sh
( dbhome, oraenv, coraenv to /usr/local/bin 
create /usr/local/bin
iSQL*Plus URL: http://localhost.localdomain:5560/isqlplus
iSQL*Plus DBA URL:http://localhost.localdomain:5560/isqlplus/dba
)
#####

###### as oracle #########
echo '
export PATH=$PATH:/usr/local/bin
export ORACLE_SID=orcl
export ORAENV_ASK=NO
export NLS_LANG="AMERICAN_AMERICA.WE8MSWIN1252"

. oraenv
'>> ~/.bashrc

. ~/.bashrc

dbca
~~~~


## Linux check before install

### Check

~~~bash
grep MemTotal /proc/meminfo      #RAM > 2G
uname -m                         #Architecture
grep SwapTotal /proc/meminfo     #Check Swap size 
free                             #Free memory
df -h /dev/shm/                  #Check shared memory
df -h /tmp                       # > 1G in tmp
echo "$TMP and $TMPDIR"          #check TMP and TMPDIR variables
cat /proc/version                #OS version
uname -r                         # OS version > 2.6.18 or later
# rpm -q package_name   # Check required packages
~~~~

### Users and groups

~~~bash
more /etc/oraInst.loc      #The Oracle Inventory group (typically, oinstall)
grep dba /etc/group        #The OSDBA group (typically, dba)
#The Oracle software owner (typically, oracle)
#The OSOPER group (optional. Typically, oper)
# Check oracle urer. Expect something like:
# uid=440(oracle) gid=200(oinstall) groups=201(dba),202(oper)
id oracle                  #usermod -g oinstall -G dba oracle
~~~

### Others

~~~bash
/sbin/sysctl -a           # Check semaphores
cat /etc/sysctl.conf

df -k                    # Mouted FS
~~~