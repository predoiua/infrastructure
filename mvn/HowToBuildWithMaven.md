
* Maven

** POM


*** Overall structure

- In top folder we have a pom.xml including child poms ( each of them in their own subfolder ) 
- Each pom contains groupId/artefactId/version ( no parent )

Eg. 
|Group id|
|--------|
|com.vv10.bi|
|com.vv10.bi.adhoc|
|com.vv10.bi.adhoc.backend|

*** Use command line

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
