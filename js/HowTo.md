
# Install a developement env for JS

## Node

### Install nvm ( Node Version Manager )

~~~
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | sh
# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm ls-remote
#Take the latest 
nvm install v5.6.0
nvm use !$
# Auto install latest
nvm install --lts    # lts = long time support
~~~

## Grunt, Brunch

~~~
npm install -g brunch
~~~

# Interesting

## JSON

http://stackoverflow.com/questions/2275359/jquery-single-quote-in-json-response
- no single quote in Json values. Only double quote have to be escaped with \
- in FreeMarker use ?json_string. ?js_string escape single quote and triger an error in browser

