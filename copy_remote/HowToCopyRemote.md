
# Copy files on remote machine

## scp

~~~
scp ~/.ssh/n*.id_rsa* n@172.17.0.1:~/
~~~

## rsync

~~~
# r recursive
# a archive
# v verbose
# e remote shell 
# --no-links = exclude symbolic links
# --delete extraneous files from desc

rsync -r -a -v -e "ssh -l bi" --delete /df 172.17.0.1:~/df
~~~
