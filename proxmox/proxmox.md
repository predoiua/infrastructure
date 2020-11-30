
# HowTo

## 1. Add local disk

~~~
fdisk -l            # find new disk
lsblk               # or with this cmd
gdisk /dev/sda      # partition disk. new primary partition, of cfdisk. Type 8e00 - LVM
pvcreate /dev/sda1  # create physical volume
lvmdiskscan         # scan all disks for lvm capabilities
~~~

### 1. Add new LVM

~~~
vgcreate ssd /dev/sda1 # create new volume group
~~~

ui: Add LVM
Datacenter –> Storage –> LVM

~~~
pvs  # /dev/nvme0n1p3 pve
vgs  # pve
lvs
~~~

### 2. Add space to an existing LV

~~~
vgextend pve /dev/sda1   # Extend Volume Group in default
vgdisplay                # check new size
lvscan                   # find the data volume to extend
lvresize -l +100%FREE pve/data # resize LV(data) to use all free space.
vgdisplay                 # confirma new disk and partition
lvdisplay
~~~

UI :
Datacentre > pve > local-lvm > Summary

Q: how to find file system type in a "logical volume"
A: blkid and lvdisplay

## 4. Add iso boot disk

pve takes boot images from "templates/iso" folder from Storage with content "ISO image"

~~~
cd /mnt/pve/qnap/template/iso
ln -s ../xx.iso xx.iso
~~~

## 3. Grow xfs

~~~
xfs_info /
xfs_growfs /
~~~