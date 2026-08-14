https://github.com/junegunn/vim-easy-align

~~~ text
apple   =red
grass+=green
sky-=   blue

Paul McCartney 1942
George Haisson 1943
Ringo Starr 1940
Pete Best 1941
~~~

~~~vim
:enew      # new buffer, <leade>n
vipga=
- `v`isual-select `i`nner `p`aragraph
- Start EasyAlign command (`ga`)
- Align around `=`
gaip=
- Start EasyAlign command (`ga`) for `i`nner `p`aragraph
- Align around `=`
gaip<space>
- 1st space
gaip2<space>
- 2nd space
gaip-<space>
- -1 space
gaip*<space>
- all spaces
~~~