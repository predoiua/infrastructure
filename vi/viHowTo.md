# vi

## vi color

~~~ sh
vi --version | grep syntax

#if -syntax =>
yum install vim-enhanced
alias vi=vim
~~~


~~~ vi
:color desert
~~~

## syntax

~~~ vi
:set syntax=sh
:set syn=off
~~~

## useful

- save and run current script

~~~ vi
:map ,t :w \|:!bash %<CR>
~~~

- comment lines

~~~ vi
ctrl-v 4j I # esc
:.,10s/^/#comment/gc
~~~

- execute replace on selection

~~~vi
:5,10s/old/new/g | 14,18 &&
:g/#comment/d
~~~

- using marks

~~~ vi
#set marks:
m a
m b
#jump between them
'a
'b
'ad'b # this will delete everything between marks a and b
~~~

- insert from OS commands

~~~ vi
:.!date
:r !date
~~~

- if don't have right to save..

~~~vi
:w !sudo tee %
~~~

## whitespace

~~~vi
set list
set nolist

#Optional :
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

#or
set expandtab ts=4 sw=4 ai
~~~

## language

~~~vi
set spell spelllang=en_us
set nospell

#]s and [s move to next/previous misspell word
#z= suggest alternatives
~~~

## color

~~~sh
ls /usr/share/vim/vim74/colors
#and
ls ~/.vim/colors
#in vim
colo blue
colorscheme blue
~~~

check terminal color capabilities:
~~~sh
tput colors
export TERM=xterm-256color
~~~

## dos2unix

~~~vi
:%s/<CTRL-V><CTRL-M>//g
#% = all lines
#<CTRL-V>=^ <CTRL-V><CTRL-M>=^M
#g=global = all occurrences on line
#instead of nothing we can user \r = new line in Unix

:set ff=dos
:set ff=unix
#where ff=file format
~~~

## fold

https://www.linux.com/learn/tutorials/442438-vim-tips-folding-fun

~~~vi
#select in visual and :
zf
#or
zf10j
~~~

## split

http://stackoverflow.com/questions/53664/how-to-effectively-work-with-multiple-files-in-vim

~~~vi
:split and :vertical split (:sp and :vs)
#naviage between windows
Ctrl-W w
#Close window
Ctrl-W c
#Increase window size
Ctrl-W +
#open file in window
:b myfile
~~~

~~~vi
:tabe file
:tabn
:tabp
#use gt and gT to navigate between tabs
~~~

## how to use leader

~~~vi
# Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>
~~~

## move/copy region

~~~
#move lines 5, 6 and 7 to after line 21
:5,7m 21
:5,7co 21
#moves down 1 line
:m +1
#move up 1 lines
:m -2
~~~

##  case sensitive/insensitive search

http://stackoverflow.com/questions/2287440/how-to-do-case-insensitive-search-in-vim

~~~
#ignore case
:set ic
:set noic
#or: case insensive per individual search
/Copyright\c
~~~

## yaml seeting

~~~
autocmd FileType yaml setlocal ai ts=2 sw=2 et
~~~