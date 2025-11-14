
Note: my tmux prefix is C-a ( vs C-b default)

alias:
~~~
tn () { stt_tab $@ && tmux new -s $@; }
ta () { stt_tab $@ && tmux a -t $@; }
~~~

~~~ in bash/tmux
tn t1   # my. start a new t1 session
C-a d   # detach
tmux ls # list existing sessions
ta t1   # my. attach to t1
C-a |   # my. split a win vertically
C-a -   # my. split a win horizontally
C-a z   # zoom. maximize a win

# navigate tmux win. my
<ctrl-h> => Left
<ctrl-j> => Down
<ctrl-k> => Up
<ctrl-l> => Right
<ctrl-\> => Previous split
~~~