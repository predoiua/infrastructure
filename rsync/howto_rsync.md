

## Usage

~~~
# a archive
# v verbose
# --no-links = exclude symbolic links

rsync -av --no-links --progress sourcefolder /destinationfolder --exclude '*.pyc'
~~~
