

## Usage

### Ex 1

~~~
# a          = archive
# v          = verbose
# --no-links = exclude symbolic links

rsync -av --no-links --progress sourcefolder /destinationfolder --exclude '*.pyc'
~~~


### Ex 2

~~~
# -P         = --partial --progress
# --partial  = keep partial transferred files
# --progress = show progress bar
rsync -av --partial --progress --append-verify bi@IP:/mnt/file .
~~~

/mnt/55a7c174-de27-4a90-b4c0-f8d65928c37e/backup_qnap_kds

~~~
# z = compress
# h = human readable
rsync -avzh src dest
~~~