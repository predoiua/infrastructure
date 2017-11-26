

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