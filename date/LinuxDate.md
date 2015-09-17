#Useful "date" in bash

~~~sh
date '+%H%M' # current time :hour(24) minutes
date +%Y%m%d #format yyyy mm dd ( no spaces )

date -d 'now + 3 weeks' # -d read time from following string

# diff between 2 dates. %s = secs since 1970-01-01 00:00:00 UTC
echo $(( ($(date -d '2015-09-17' +%s) - $(date -d '2015-08-16' +%s))/(24*60*60) ))
~~~
