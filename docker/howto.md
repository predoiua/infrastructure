## General

- ADD commands can't use .. in path. So Dockerfile must be in the build root.

## Install


### Cent OS 6 

See https://docs.docker.com/installation/centos/

~~~ bash
#64 bits
su -c 'rpm -Uvh http://epel.mirror.constant.com/6/x86_64/epel-release-6-8.noarch.rpm'
sudo yum install docker-io
# start it
sudo service docker start
# start at server boot
sudo chkconfig docker on
~~~

### CentOS 7
http://wiki.centos.org/Cloud/Docker

~~~ bash
# start it
sudo systemctl start docker
# start at service boot
sudo systemctl enable docker
~~~

## Usefull

### Remove old contains

~~~ bash
docker ps -a | awk '{print $1}' | xargs docker rm {} \;
# or
docker rm `docker ps -aq`
~~~

### Launch Interactive container

~~~ bash
docker run -t -i --rm ubuntu /bin/bash
~~~

### Background container

~~~ bash
# launch a container and run some task
docker run -d ubuntu /bin/bash -c "while true; do echo hello world; sleep 1; done"

# get container id
docker ps
# view output
sudo docker logs angry_mccarthy
# stop it
sudo docker stop angry_mccarthy
~~~

### Connect to a container running as demon

~~~ bash
docker run -p 8080:8080 -v /home/vagrant/data/jenkins:/var/jenkins_home jenkins 

docker exec -it [container-id] /bin/bash
~~~

### Shutdown a daemon 

~~~ bash
docker stop `docker ps -q`
~~~

### Build image form Dockefile

~~~ bash
docker build -t predoiua/adhoc_be .
# don't use cache
docker build -t --no-cache predoiua/adhoc_be .
~~~

### Build image form running container

~~~ bash
docker commit <container> <image>
~~~~

### Cleanup

~~~ bash
docker rm -v $(docker ps -a -q -f status=exited)

docker rmi $(docker images -f "dangling=true" -q)

docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
~~~

### Get IP

~~~bash
docker inspect <container> | grep IP
~~~

### Move image to a diff machine

http://stackoverflow.com/questions/23935141/how-to-copy-docker-images-from-one-host-to-another-without-via-repository

~~~
docker save -o <save image to path> <image name>
#Then copy your image to a new system with regular file transfer tools such as cp or scp. After that you will have to load the image into docker:

docker load -i <path to image tar file>
~~~


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

