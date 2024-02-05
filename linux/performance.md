
# Profiling Linux Activity for Performance and Troubleshooting

https://www.youtube.com/watch?v=YEWp3O7Kem8&ab_channel=TanelPoder


ps -o pid,ppid,tid,thcount,comm -p 1994 # thcount = multi thread
ps -o pid,ppid,tid,thcount,comm -L -p 1994 | head # -L show thread,
    # thread group leader PID = TID
ps -eLf | wc -l
ls -ld /proc/[0-9]* | wc -l
ls -ld /proc/[0-9]*/task/*  | wc -l # non leader are in task


ps -o s read states from /proc/PID/stat
ps -eo s,comm | sort | uniq -c | sort -nbr | head
ps -eo s,comm,wchan | sort | uniq -c | sort -nbr | head

nice stress -c 32   # basic stress test
ps -eo state,user,comm | grep "^R" | uniq -c | nosrt -nbr

vmstat 3  
dstat -vr