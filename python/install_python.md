

# Set up a dev env

based on 
http://stackoverflow.com/questions/4324558/whats-the-proper-way-to-install-pip-virtualenv-and-distribute-for-python

## Make inital folder structure

~~~
mkdir ~/python
cd ~/python
~~~~

## Download initial virtual env script

~~~
curl -0 https://pypi.python.org/packages/8b/2c/c0d3e47709d0458816167002e1aa3d64d03bdeb2a9d57c5bd18448fd24cd/virtualenv-15.0.3.tar.gz#md5=a5a061ad8a37d973d27eb197d05d99bf
~~~

## Create virtual python environments

~~~
# Select current version of virtualenv:
VERSION=15.0.3
# Name your first "bootstrap" environment:
INITIAL_ENV=bootstrap
# Set to whatever python interpreter you want for your first environment:
PYTHON=$(which python)

# We already done this download part
#URL_BASE=https://pypi.python.org/packages/source/v/virtualenv
#curl -O $URL_BASE/virtualenv-$VERSION.tar.gz

# --- Real work starts here ---

tar xzf virtualenv-$VERSION.tar.gz

# Create the first "bootstrap" environment.
$PYTHON virtualenv-$VERSION/virtualenv.py $INITIAL_ENV
# Don't need this anymore.
rm -rf virtualenv-$VERSION
# Install virtualenv into the environment.
$INITIAL_ENV/bin/pip install virtualenv-$VERSION.tar.gz

~~~

Environment to reporting

~~~
# Create a second environment from the first:
$INITIAL_ENV/bin/virtualenv py-reporting
# Make it active
source py-reporting/bin/activate
~~~