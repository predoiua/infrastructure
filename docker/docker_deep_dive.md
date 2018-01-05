# Docker deep dive

## Docker version

~~~
docker -v                   # version
docker version              # more 
docker info                 # even more
~~~

## Docker server port

~~~
ls -l /var/run/docker.sock         # docker listen to this socket by default
netstat -tlp                       # check there is no docker listening on tcp
service docker stop
docker -H 192.168.56.50:2375 -d &  # start docker with tcp listening
docker info                        # failure as it try to use unix socket
# other machine
export DOCKER_HOST="tcp://192.168.56.50:2375"
docker version                     # for server extract info from docker server
~~~

## Usage examples

~~~
docker run -it centos /bin/bash   # start a centos container
# in container
uname -a                          # show kernel version of host !!
vi /tmp/tempfile
exit
# in host
docker ps -a                         # see all previously run container
ls -l /var/lib/docker/aufs/diff/     # images with all containers
ls -l /var/lib/docker/aufs/diff/sha  # list modification form that container
cat /var/lib/docker/aufs/diff/sha/tmp/tempfile # see the file created in container
# start again containser
docker start sha
docker attach sha
cat /tmp/tempfile                    # the file still exists
~~~

- inside container : CTRL - P - Q = exit, but leave container running

## Layers

~~~
docker images --tree              # see layers in a image
docker history image              # layesr of that images
~~~

## Export a container

~~~ 
docker commit container_sha frigde       # create  fridge image form a container
docker history frigde                    # check it
docker save -o /tmp/fridge.tar fridge    # save image in tar
tar -tf /tmp/fridge.tar                  # list file inside tar
docker load -i /tmp/fridge.tar           # import image on a different machine
~~~

## Build container

- build is done by daemon, all data are send to daemon before build
- spec file name : Dockerfile

~~~
# comment
FROM ubuntu:15:04
MAINTAINER i@i.com
RUN apt-get update
CMD ["echo","Hello World"]
~~~

~~~
docker build -t hello:0.1 .  # -t tag . = include local folder
~~~