
# Basic tmux

Check
https://robots.thoughtbot.com/a-tmux-crash-course

Prefix = Control + b 

## Sessions

~~~
tmux new -s first          # start a new session, named "first"
tmux detach (prefix + d)   # Detach
tmux attach -t first       # Attact
~~~

## Windows

~~~
tmux new-window (prefix + c)                  # create a new win
tmux select-window -t :0-9 (prefix + 0-9)     # select a win
tmux rename-window (prefix + ,)               # rename
~~~