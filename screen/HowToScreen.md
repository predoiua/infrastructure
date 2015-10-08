

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

## attach to an existing session

~~~bash
screen -x # attach to existing session
screen -dRR # force to connect to a session
~~~

##Screen commands

CTR = Ctrl-A or Ctrl-T

- CTR d = detach
- CTR c = open a new terminal
- CTR A = rename window
- CTR 0-N = select windows with this number
- CTR :kill = kill a frozen tab
