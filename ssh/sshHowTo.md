
# Install

config file : /etc/ssh/sshd_config

CentOS 6.6

## On remote server

in Docker image:

~~~bash
docker run -it --rm centos:6.6 /bin/bash

yum search ssh
yum list installed openssh-server
#or yum info openssh-server
#or rpm -qa | grep ssh
yum install openssh-server
vi /etc/ssh/sshd_config
#set UsePAM=no
useradd n

#for scp. It needs to be install at both source and destination
yum -y install openssh-clients

#this step will generate RSA & DSA keys. without them next step will fail
service sshd start


# -D = don't detach, 
# -d = debug, multiple d increase logging level
# -e = log at std out
/usr/sbin/sshd -p 2222 -ddd

#as n
mkdir .ssh
chmod 0700 .ssh
touch ~/.ssh/authorized_keys
chmod 0640 ~/.ssh/authorized_keys
~~~

## On local machine

Linux host:

~~~bash
docker inspect xxx | grep IPAddress

cat ~/.ssh/id_rsa.pub | ssh n@172.17.0.1 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"

#scp ~/.ssh/n*.id_rsa* n@172.17.0.1:~/

ssh 172.17.0.1
The authenticity of host '172.17.0.5 (172.17.0.5)' can't be established.
RSA key fingerprint is 01:d1:5e:7c:3f:71:48:9d:61:20:13:7d:f5:15:39:43.
Are you sure you want to continue connecting (yes/no)? yes

ssh -i ~/.ssh/id_rsa u@172.17.0.1
~~~

## Other

### Secure copy file from script

~~~
sshpass -p 'passs' sftp  user@host << FIN
        put file destination
        bye
FIN
~~~

### Generate ssh key

~~~
ssh-keygen -t rsa -f ~/.ssh/ansible_id_rsa -C "predoiua.vv10@gmail.com"
~~~

### Copy ssh key

~~~
scp ~/.ssh/ansible_id_rsa.pub predoiua@172.17.0.1:~/ansible_id_rsa.pub
cat ~/ansible_id_rsa.pub >> ~/.ssh/authorized_keys
~~~

### Copy ssh key 2

~~~
# -i = 
ssh-copy-id  -i ~/ansible_id_rsa.pub predoiua@172.17.0.1
~~~