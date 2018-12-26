
~~~
httpd -v   # check apache version

# list install modules
apachectl -M # ubuntu
httpd -M     # centos

# find where a module is loaded
grep headers_module /etc/httpd/conf.modules.d/*
~~~


