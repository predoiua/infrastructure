# Java 8

#http://www.webupd8.org/2012/09/install-oracle-java-8-in-ubuntu-via-ppa.html

~~~
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update

#optional - for auto confirmation
echo "oracle-java-8-installer shared/accepted-oracle-license-v1-1 select true" | sudo /usr/bin/debconf-set-selections

sudo apt-get install oracle-java8-installer
sudo apt-get install -y oracle-java8-set-default
~~~


# Java 11

For Oracle Java 11, see a different PPA -> 
https://www.linuxuprising.com/2018/10/how-to-install-oracle-java-11-in-ubuntu.html
