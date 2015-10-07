

# useful

##Kill a rogue screen session:

~~~bash
#if everything goes wrong:
screen -list
# same as :screen -ls 
screen -X -S [session] quit
~~~

##run a command in a new screen instance

~~~ bash
screen -d -m -S boot_app ./boot_app
#later reconnect
screen -ls
screen -DR sess.boot_app
~~~

##Screen commands

ctrt-t d  # detach

attach
screen -x # attach to existing sssion
screen -dRR # force to connect to a session



CTR = Ctrl-A or Ctrl-T

- CTR c = open a new terminal
- CTR A = rename window
- CTR 0-N = select windows with this number
