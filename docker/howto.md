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

### Connect to a conatiner running as demon

~~~ bash
docker run -p 8080:8080 -v /home/vagrant/data/jenkins:/var/jenkins_home jenkins 

docker exec -it [container-id] /bin/bash
~~~

### Shutdown a daemon 

~~~ bash
docker stop `docker ps -q`
~~~

### Build form Dockefile

~~~ bash
docker build -t predoiua/adhoc_be .
# don't use cache
docker build -t --no-cache predoiua/adhoc_be .
~~~

### Cleanup

~~~ bash
docker rm -v $(docker ps -a -q -f status=exited)

docker rmi $(docker images -f "dangling=true" -q)

docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
~~~
