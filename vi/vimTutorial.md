
https://www.youtube.com/watch?v=E-ZbrtoSuzw
# few feature

vimrc
~~~
let g:solarized_termtrans=1 " terminal setting for colors
colorscheme salarized8_high "Pretty colors. better TAB to choose schema 
set bg=dark       " dark background"
set shiftwidth=4  " indenting " sw
set path=**       " recursive file search
set softtabstop=4 " nr of spaces for tab" st
set expandtab     " spaces, no tab"
set relativenumber " great !"
set noswapfile
set hidden   "allow switching buffer without writing"
set wildignore+=**/virtualenv

let g:netrw_banner = 0 " no header in directory"
let g:netrw_liststyle =3 " tree style"

~~~

:20vs .   # 20 char visual split current directory !!!

https://www.youtube.com/watch?v=XA2WjJbmmoM

https://github.com/changemewtf/no_plugins/blob/master/no_plugins.vim

# 4 features

set nocomplatible # don't pretend to be vi

syntax enable
filetype plugin on  # for file browser


## finding file

set path+=**    # search subfolder, provide tab-completion for file related stuff
set wildmenu    # display all matching files on tab complete

:find *.yaml 
-
:ls      # list buffers
:b tcp   # jump to buffer, or use tab

## tag jump

ctags -R .  # generate tags file
^]   jump to tag under cursor
g^]  for ambigous tags
^t   jump back up the tag stack


## file navigation

