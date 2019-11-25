# General

vagrant ssh.
https://stackoverflow.com/questions/10864372/how-to-ssh-to-vagrant-without-actually-running-vagrant-ssh

~~~
HOST=name-of-my-host
ssh $(vagrant ssh-config $HOST | sed '/^[[:space:]]*$/d' |  awk 'NR>1 {print " -o "$1"="$2}') localhost
~~~

# Install minimal Centos 7 with GUI

## Check local software
Required:
- VirtualBox
- Vagrant

~~~
vboxmanage --version         # VirtualBox version
vagrant --version
~~~

## Download Centos 7 Vagrant box

Go to : http://www.vagrantbox.es/ and choose a box

~~~
# box operation
vagrant box list
vagrant box add centos/7
vagrant box update            # update box eg. form box version 1509.01 to latest one
vagrant box remove centos/7 --box-version=1509.01
# start
vagrant up
# start again
vagrant halt
vagrant up
~~~

Attention : I get an error related to shared folder. 
Solution :
vagrant plugin install vagrant-vbguest
More detail at : https://github.com/mitchellh/vagrant/issues/3341 


## Boot in GUI Mode

### CentOS 7
http://idroot.net/tutorials/install-gnome-gui-centos-7/

~~~
ln -sf /lib/systemd/system/runlevel5.target /etc/systemd/system/default.target
~~~

### CentOS 6

~~~
sudo vi /etc/inittab
	change line:
	id:3:initdefault:
	to
	id:5:initdefault:
sudo reboot
~~~
