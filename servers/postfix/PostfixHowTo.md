# Postfix

~~~
tail /var/log/mail.log  # debug email
/etc/aliases  # for email aliases

postconf -n   # display non-default postfix configuration
postconf -p   # print all postfix parameters

postqueue -p  # print mail queue
postqueue -f  # flush - try to delivery all mails

~~~

configuration
vi /etc/postfix/main.cf

myhostname
mydomain
myorigin

~~~
service postfix status
~~~


echo "This is the body of the email" | mail -s "This is the subject line" predoiu_seli@gmail.com
