

## Minimal install

~~~
yum group install "GNOME Desktop"
~~~

## Install dependecies

~~~
cd /etc/yum.repos.d
wget https://public-yum.oracle.com/public-yum-ol7.repo
wget https://public-yum.oracle.com/RPM-GPG-KEY-oracle-ol7 -O /etc/pki/rpm-gpg/RPM-GPG-KEY-oracle
yum install oracle-rdbms-server-11gR2-preinstall
~~~


vi /etc/hosts

## Create oracle

~~~
groupadd oinstall
groupadd dba
groupadd oracle
useradd -g oinstall -G dba oracle
passwd oracle
~~~


## install

- ignore warnings
- create db: dbca