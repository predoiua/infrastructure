

# Set up a dev env

based on 
http://stackoverflow.com/questions/4324558/whats-the-proper-way-to-install-pip-virtualenv-and-distribute-for-python

https://pypi.org/project/virtualenv/

## Make inital folder structure

~~~
mkdir ~/python
cd ~/python
~~~~

## Download initial virtual env script

~~~
# We already done this download part
curl -O https://files.pythonhosted.org/packages/8b/f4/360aa656ddb0f4168aeaa1057d8784b95d1ce12f34332c1cf52420b6db4e/virtualenv-16.3.0.tar.gz

tar xzf virtualenv-$VERSION.tar.gz
~~~

## Create virtual python environments

~~~
# Select current version of virtualenv:
VERSION=16.3.0
# Name your first "bootstrap" environment:
INITIAL_ENV=bootstrap
# Set to whatever python interpreter you want for your first environment:
PYTHON=$(which python)

# --- Real work starts here ---
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