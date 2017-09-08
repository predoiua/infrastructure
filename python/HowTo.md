
# Test

~~~
python -m unittest -h
#python -m unittest  test_schema
python -m unittest discover -s tests -p "test_*.py"
~~~


# Simple www server

~~~
python -m SimpleHTTPServer 9000
~~~

# Green/Blue deploy

~~~
virtualenv blue
./green/bin/my-app stop
./blue/bin/pin install -r requirements.txt --no-index --find-links WHEELS 
./blue/bin/my-app start
rm -rf green
~~~
