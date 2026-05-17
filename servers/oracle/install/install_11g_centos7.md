

## Minimal install

~~~
yum group install "GNOME Desktop"
~~~



## Install dependecies


~~~
while read -r line
do
    if [[ -z "$line" ]]; then
        continue;
    fi
    echo "Name read from file - $line"
    yum install -y $line
done < <( echo "
	binutils
	compat-libcap1
	compat-libstdc++
	compat-libstdc++
	gcc-4.8.2-3.el7.x86_64
	gcc-c++-4.8.2-3.el7.x86_64
	glibc-2.17-36.el7.i686
	glibc-2.17-36.el7.x86_64
	glibc-devel-2.17-36.el7.i686
	glibc-devel-2.17-36.el7.x86_64
	ksh
	libaio-0.3.109-9.el7.i686
	libaio-0.3.109-9.el7.x86_64
	libaio-devel-0.3.109-9.el7.i686
	libaio-devel-0.3.109-9.el7.x86_64
	libgcc-4.8.2-3.el7.i686
	libgcc-4.8.2-3.el7.x86_64
	libstdc++-4.8.2-3.el7.i686
	libstdc++-4.8.2-3.el7.x86_64
	libstdc++-devel-4.8.2-3.el7.i686
	libstdc++-devel-4.8.2-3.el7.x86_64
	libXi-1.7.2-1.el7.i686
	libXi-1.7.2-1.el7.x86_64
	libXtst-1.2.2-1.el7.i686
	libXtst-1.2.2-1.el7.x86_64
	make-3.82-19.el7.x86_64
	sysstat-10.1.5-1.el7.x86_6
")
~~~


	binutils-2.23.52.0.1-12.el7.x86_64
	compat-libcap1-1.10-3.el7.x86_64
	compat-libstdc++-33-3.2.3-71.el7.i686
	compat-libstdc++-33-3.2.3-71.el7.x86_64
	gcc-4.8.2-3.el7.x86_64
	gcc-c++-4.8.2-3.el7.x86_64
	glibc-2.17-36.el7.i686
	glibc-2.17-36.el7.x86_64
	glibc-devel-2.17-36.el7.i686
	glibc-devel-2.17-36.el7.x86_64
	ksh
	libaio-0.3.109-9.el7.i686
	libaio-0.3.109-9.el7.x86_64
	libaio-devel-0.3.109-9.el7.i686
	libaio-devel-0.3.109-9.el7.x86_64
	libgcc-4.8.2-3.el7.i686
	libgcc-4.8.2-3.el7.x86_64
	libstdc++-4.8.2-3.el7.i686
	libstdc++-4.8.2-3.el7.x86_64
	libstdc++-devel-4.8.2-3.el7.i686
	libstdc++-devel-4.8.2-3.el7.x86_64
	libXi-1.7.2-1.el7.i686
	libXi-1.7.2-1.el7.x86_64
	libXtst-1.2.2-1.el7.i686
	libXtst-1.2.2-1.el7.x86_64
	make-3.82-19.el7.x86_64
	sysstat-10.1.5-1.el7.x86_6

~~~
NO :
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