# GnuPG

Cheatsheet:
http://irtfweb.ifa.hawaii.edu/~lockhart/gpg/
Export/import:
https://gist.github.com/chrisroos/1205934

## Generate key / Export key

~~~sh
gpg --gen-key
gpg --export -a "AP" > AP-public.key
~~~

## Backup

Something fishy here...

~~~sh
gpg --export-ownertrust >AP-gpg.txt
gpg --import-ownertrust AP-gpg.txt
~~~