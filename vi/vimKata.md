
https://www.youtube.com/watch?v=E-ZbrtoSuzw

~~~
cd ~/git
git clone https://github.com/leeren/Vim-Demo.git
cd ~/git/Vim-Demo/1
vi -u NONE -O *   # no customizations , -O split
:windo difft      # highlight diff
:e!               # reload changes form disk
:set showcmd      # display keystokes
6+
WW
gUaw
3j
w
3ce
4$
i
]m
d]m
%
~~~

# operators, text, motions
## Operators

c  change
d  delete
y  yank into register
~  swap case
gu make lowercase. GO LOWERCASE
gU make uppercase
!  filter to external progr
<  shift left
>  shift right
=  indent

## Text object

aw a word
iw inner word
aW  a WORD
iW  inner WORD
ap  a pararaph
ip  inner paragraph
ab  a bracket
at  a tag block

## motion

%                  go to first matchink paren / bracket
[count]+           down to first non-bank char of line
[count]$           to end of line
[count]f/F{char}   to next occurence on {char}
[count]t/T{char}   to before occurence on {char}
[count]h/j/k/l 
[count]]m          go to beginning of next method
[count]w/W         go a W to right
[count]b/B         go a W to left
[count]e/E         go to end of W


:he motion.txt


## advanced navigation

### scrolling
H M L
ctrl-U ctrl-Y/crtl-E ctrl-D

:windo filetype plugin indent on | set ft=python | sy on | set sw=4 sts=4 ts=8 bs=2 et ai nocompatible | set bg=dark | execute "normal \<c-w>h" | set hidden | set rnu


set runtimepath^=~/.vim 