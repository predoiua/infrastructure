
#Install

~~~bash
apt-get install -y openssh-server &&
    mkdir /var/run/sshd &&
    echo 'root:admin' | chpasswd &&
    sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd &&
    echo "export VISIBLE=now" >> /etc/profile &&
~~~

config file : /etc/ssh/sshd_config

CentOS 6.6

in Docker image:

~~~bash
yum search ssh
yum list installed openssh-server
#or yum info openssh-server
#or rpm -qa | grep ssh
yum install openssh-server
vi /etc/ssh/sshd_config
#disabble PAM..
useradd n

# -D = don't detach, 
# -d = debug
# -e = log at std out
/usr/sbin/sshd -p 2222 -D -d -e
~~~

In Linux host:

~~~bash
scp n@172.17.0.5:~/.ssh/n*.id_rsa* ~/

ssh 172.17.0.5
The authenticity of host '172.17.0.5 (172.17.0.5)' can't be established.
RSA key fingerprint is 01:d1:5e:7c:3f:71:48:9d:61:20:13:7d:f5:15:39:43.
Are you sure you want to continue connecting (yes/no)? yes
~~~
