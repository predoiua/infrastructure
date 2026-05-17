
# Jenkins

CentOS 8
( on "test" vagrant )

sudo yum install java-1.8.0-openjdk-devel.x86_64

~~~
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins
~~~
or
~~~
wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
~~~

java -jar jenkins.war

http://192.168.4.201:8080


https://github.com/nsadawi/JenkinsPrimer

## Capability

- deploy to Docker repo
- blue ocean - ?
- pipeline = the future of jenkins

