# Virtual box

## Nested virtualization

~~~
VBoxManage modifyvm Fedora.31 --nested-hw-virt on              # Enable VT-x for VM Fedora.31
~~~


## Fedora 31

~~~
sudo dnf -y update
sudo dnf -y install gcc automake make kernel-headers kernel-devel perl
sudo /run/media/user/VBOXADDITIONS*/VBoxLinuxAdditions.run
~~~


## Fail to download addon iso

https://unix.stackexchange.com/questions/516106/cant-install-guest-additions-to-virtualbox-an-unauthorized-request
https://download.virtualbox.org/virtualbox/6.0.6/VBoxGuestAdditions_6.0.6.iso
