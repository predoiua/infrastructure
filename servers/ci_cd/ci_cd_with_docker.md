
# Continous integration 
based on Sean P. Kane O'reilly course

Introduction to Docker CI/CD
https://learning.oreilly.com/videos/introduction-to-docker/0636920668879/
https://gist.github.com/spkane/0631ee08aafed0b707e0eba64242e5d0


## How to
Create CI-CD-Docker on pve - CentOS7
~~~
sudo -i
hostnamectl set-hostname cicd.work.vv10.eu
~~~

install docker see: docker/howto.md ( this repository )

~~~
cd ${HOME}
mkdir class
cd class
mkdir code
git clone https://github.com/spkane/docker201.git layout \
    --config core.autocrlf=input
cd layout
ls
~~~

## Docker compose up
~~~
cd compose
vi docker-compose.yaml
## change 
##    - "../../registry/certs:/certs"
## to 
##    - "../registry/certs:/certs"
echo 'MY_PG_PASS=myuser-pw!' > ./.env
docker compose config
docker compose up -d
docker compose ps
docker compose logs -f
docker compose stop
~~~

reset .. or better rm -rf & get from github again.
~~~
docker compose down
../scripts/class-docker-cicd/clean-all-data.sh
../scripts/class-docker-cicd/clean-jenkins-data.sh
~~~


## Configure Gogs
Navigate web browser to:
http://cicd:10090/install

~~~
Host: postgres:5432
User: postgres
Password: myuser-pw!
SSH Port: 10022
Application URL: http://cicd:10090/
~~~
Create Gogs User
~~~
Click: Admin Account Settings
Username: s
Password: s
Email Address: myuser@example.com
Click: Install Gogs
~~~


## Push a docker image to registry
registry
http://cicd:5000

10.10.10.92 private-registry.localdomain

Password:
Error response from daemon: Get 
https://private-registry.localdomain:5000/v2/"
ping private-registry.localdomain

Error response from daemon: Get "https://private-registry.localdomain:5000/v2/": tls: failed to verify certificate: x509: certificate is not valid for any names, but wanted to match private-registry.localdomain
see: san.cnf

openssl s_client -showcerts -connect localhost:5000
curl --insecure -X GET https://localhost:5000/v2/_catalog
curl --insecure -X GET https://localhost:5000/v2/myuser/outyet/tags/list

docker pull 127.0.0.1:5000/myuser/outyet:5ded2e63669cf91d430abfe46bad37e911f5691c
docker run -d -p 8080:8080 127.0.0.1:5000/myuser/outyet:5ded2e63669cf91d430abfe46bad37e911f5691c


~~~
docker login private-registry.localdomain:5000

cd ~/layout/outyet
docker build -t go_http .
docker image ls
docker image tag go_http cicd:5000/myuser/go_http:latest
docker image push cicd:5000/myuser/go_http:latest
~~~

## Jenkins

sudo cat ~/jenkins/data/secrets/initialAdminPassword
95119ff8b0af40039b12514fe1c20555

http://cicd:10091/

