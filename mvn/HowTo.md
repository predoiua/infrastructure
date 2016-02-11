
# Maven

## Install

https://maven.apache.org/install.html

- download zip
cd ~/opt
wget http://apache.mirrors.pair.com/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar xvzf apache-maven-3.3.9-bin.tar.gz
rm !$
ln -s ~/opt/apache-maven-3.3.9/bin/mvn ~/bin/mvn

## POM


### Overall structure

- In top folder we have a pom.xml including child poms ( each of them in their own subfolder ) 
- Each pom contains groupId/artefactId/version ( no parent )

Eg. 
|Group id|
|--------|
|com.vv10.bi|
|com.vv10.bi.adhoc|
|com.vv10.bi.adhoc.backend|

### Use command line

~~~sh
#Compile
mvn compile
#Build jar/war file
mvn clean install -am -DskipTests
#Run in Tomcat servlet container
mvn clean install -DskipTests tomcat7:run
#test it:
http://localhost:8080/adhoc/api.html
~~~

