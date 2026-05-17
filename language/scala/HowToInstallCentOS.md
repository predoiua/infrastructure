

# Install

Details:
 http://decisionstats.com/2014/04/15/installing-scala-on-centos/


~~~ bash
cd ~/opt
scala_ver="2.11.8"
curl -O http://www.scala-lang.org/files/archive/scala-${scala_ver}.tgz
tar xvf scala-${scala_ver}.tgz
ln -s ~/opt/scala-${scala_ver}/bin/scala ~/bin/scala

scala -version
~~~