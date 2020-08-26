
https://plusbryan.com/my-first-5-minutes-on-a-server-or-essential-security-for-linux-servers

2013

2 accounts
- root
- deploy

# deploy
- sudo via long passwd
- devs log in with public key
admin = keep authorized_key up to date

# what
- passwd # root, long, not used
- apt update & upgrade
- apt install fail2ban # monitor logs, block auspicious activity
- user deploy
~~~
useradd deploy
mkdir -p /home/deploy/.ssh
chmod 700 /home/deploy/.ssh
~~~
- require public key
~~~
vi /home/deploy/.ssh/authorized_keys # add id_rsa.pub
chmod /home/deploy/.ssh/authorized_keys
chown deploy:deploy /home/deploy -R
~~~
- test user and enable sudo
~~~
passwd deploy # memorable passwd. used for sudo
visudo 
# root ALL=(ALL) ALL
# deploy ALL=(ALL) ALL
~~~
- lock down ssh
~~~
vim /etc/ssh/sshd_config
# PermitRootLogin no
# PasswordAuthentication no
# AllowUsers deploy@(your-ip)
systemctl restart ssh
~~~
- enable auto security updates
- install logwatch 
monitor logs and email them
