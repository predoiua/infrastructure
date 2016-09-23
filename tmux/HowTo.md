
# Basic tmux

Check
https://robots.thoughtbot.com/a-tmux-crash-course

Prefix = Control + b 

## Sessions

~~~
# start a new session, named "first"
tmux new -s first
# Detach
tmux detach (prefix + d)
# Attact
tmux attach -t first
~~~

## Windows

~~~
# create a new win
tmux new-window (prefix + c)
# select a win
tmux select-window -t :0-9 (prefix + 0-9)
# rename
tmux rename-window (prefix + ,)
~~~