## General

- ADD commands can't use .. in path. So Dockerfile must be in the build root.

## Install

### Alma 9 - using CentOS repo
~~~
# set up repository
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
# install
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# enable
systemctl enable --now docker.service
systemctl enable --now containerd.service
~~~

### CentOS 7

~~~ bash
systemctl start docker          # start it
systemctl enable docker         # start at service boot
~~~

## Usefull

### Allow user to use docker
~~~
usermod -aG docker $USER    # add user to "docker" group
newgrp docker               # activate the change
~~~

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
docker run -d ubuntu /bin/bash -c "while true; do echo hello world; sleep 1; done"       # launch a container and run some task
docker ps                                                                                # get container id
docker logs angry_mccarthy                                                          # view output
docker stop angry_mccarthy                                                          # stop it
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

# obsolete
# docker run -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker --rm martin/docker-cleanup-volumes
docker volume rm $(docker volume ls -qf dangling=true)
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


