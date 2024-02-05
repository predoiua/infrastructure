
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

### COnfig

chmod 0600 ~/.ssh/config
vi  ~/.ssh/config
~~~
Host vm1
    HostName vm1
    Port 22
    User ansible
    IdentityFile ~/.ssh/ansible_id_rsa
~~~

### Tunnel

https://nerderati.com/2011/03/17/simplify-your-life-with-an-ssh-config-file/

~~~
# -f puts ssh in background
# -N makes it not execute a remote command
ssh -f -N -L 9906:127.0.0.1:3306 coolio@database.example.com
~~~

This will forward all local port 9906 traffic to port 3306 on the remote database.example.com server, letting me point my desktop GUI to localhost (127.0.0.1:9906) and have it behave exactly as if I had exposed port 3306 on the remote server and connected directly to it.

=

Host tunnel
    HostName database.example.com
    IdentityFile ~/.ssh/coolio.example.key
    LocalForward 9906 127.0.0.1:3306
    User coolio

ssh -f -N tunnel

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
# -i = identity file
ssh-copy-id  -i ~/ansible_id_rsa.pub predoiua@172.17.0.1
~~~

### Disconnect

To disconnect a locked-up ssh session, type ~.
For all key combinations: ~?

### github

~~~
ssh -vT git@github.com     # test if public key are correctly in place.
~~~


## Remove key form known hosts

~~~
ssh-keygen -R hostname
~~~

## Force to connect with password

~~~
ssh -o PreferredAuthentications=password -o PubkeyAuthentication=no example.com
~~~

## ssh-agent

env variables:
SSH_AUTH_SOCK=/tmp/ssh-AIKJniK2zVwp/agent.248
SSH_AGENT_PID=249

~~~
eval $(ssh-agent) # will set the 2 env variables
ssh-add
~~~