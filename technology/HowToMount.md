

# Usage

~~~ bash
umount /mnt/dump02
mount -o rw -t nfs 192.168.1.10:/volume1/Dumps /mnt/dump02

# Append line form mtab to fstab
cat /etc/mtab | grep 192.168.1.10

vi /etc/fstab
~~~