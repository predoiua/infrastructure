### Mint 17.x


cat /etc/default/docker

~~~
# Docker Upstart and SysVinit configuration file

# Customize location of Docker binary (especially for development testing).
#DOCKER="/usr/local/bin/docker"

# Use DOCKER_OPTS to modify the daemon startup options.
#DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"
#DOCKER_OPTS="-g /media/predoiua/Data-ext1/docker"
#DOCKER_OPTS="-g /media/predoiua/Data-ext/docker_ssd/docker"
DOCKER_OPTS="--dns 172.20.10.91 -g /media/predoiua/Data-ext/docker_ssd/docker"


# If you need Docker to use an HTTP proxy, it can also be specified here.
#export http_proxy="http://127.0.0.1:3128/"

# This is also a handy place to tweak where Docker's temporary files go.
#export TMPDIR="/mnt/bigdrive/docker-tmp"
export TMPDIR="/media/predoiua/Data-ext/docker"
~~~

### Mint 18.x  (systemd)

cat /lib/systemd/system/docker.service

~~~
ExecStart=/usr/bin/dockerd -H fd:// --dns 172.20.10.91 -g /media/predoiua/Data-ext/docker_ssd/docker
~~~

