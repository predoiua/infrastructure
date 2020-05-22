
# RH199 

8. Creating and mounting FS
pg - 193

## 12. Logical Volume Management
pg - 317
CentOS 7
~~~
yum install lvm2
~~~


### Prepare physical device

~~~
# created a LVM partition
gdisk /dev/vdb   # or parted /dev/vdb  # or fdisk /dev/vdb   #
partprobe        # register new partition with kernel
~~~

~~~
# usage :
# prepare_disk /dev/vdc
function prepare_disk() {
(
    echo n # Add a new partition
    echo   # Partition number ( default: 1)
    echo   # First sector (Accept default: 2048 )
    echo   # Last sector (Accept default: varies)
    echo 8e00       # hexcode or GUID  8e00 Linux LVM 
    echo w # Write changes
    echo Y # confirm
) | gdisk $1
}
~~~


~~~
### Create physical volume
pvcreate /dev/vdb1 /dev/vdc1     # label partition as PV
### Create a volume group
vgcreate vg-alpha /dev/vdb1 /dev/vdc1    # create  pool = volume group
### Create a logical volume
lvcreate -n largedb -l 100%FREE vg-alpha   # create with name , fill all FREE space
### add fs
mkfs -t xfs /dev/vg-alpha/largedb
### mount it
mkdir /u01
echo "/dev/vg-alpha/largedb /u01 xfs defaults 1 2" >>/etc/fstab
mount -a
## review status
pvdisplay /dev/vdc1
vgdisplay vg-alpha
~~~


name
/dev/vgname/lvname      # traditional name
/dev/mapper/vgname-lvname


