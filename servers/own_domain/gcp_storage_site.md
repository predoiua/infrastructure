
# Static site in GCP storage


https://www.youtube.com/watch?v=HkJxy22P5gk

https://cloud.google.com/storage/docs/hosting-static-website

~~~
http://storage.googleapis.com/www.example.com/index.html
~~~

https://cloud.google.com/storage/docs/hosting-static-website

step1 :
wwww.vv10.eu CNAME c.storage.googleapis.com
step 2 :
create bucket
www.vv10.eu
make it public : allUsers, CloudStrageViewer
step 3:
add content
gsutil rsync -R local-dir gs://www.vv10.eu

public at:
https://storage.googleapis.com/www.vv10.eu/index.html
