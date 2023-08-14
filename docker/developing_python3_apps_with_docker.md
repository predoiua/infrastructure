

# Based on "Developing Python 3 Apps with Docker" by 
Steven Haines
on Pluralsight
https://app.pluralsight.com/library/courses/python-apps-docker-developing/table-of-contents

https://github.com/geekcap-pluralsight/python-docker

## Basic
~~~
docker build -t prodsrv:1.0 .       # -t = --tag. default latest
docker images | grep -E 'prod|REPO' # only this img and header
docker run -d -p 5000:5000 prodsrv:1.0 # run it
curl http://alma9:5000/products
docker exec -it 8a bash         # connect to a running container by id. Note: will land in Dokerfile WORKDIR
docker stop 8a                  # stop container.
~~~

## Docker compose
