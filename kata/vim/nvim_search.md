
# incremenatal search
https://github.com/haya14busa/incsearch.vim

/   = forward search
    = . = any char
*   = forward by word under cursor

while searching:
TAB = next match
S-TAB = prev match
C-j   = scroll next page
C-k   = scroll prev

# sneak
https://github.com/justinmk/vim-sneak
jump 2 any location by 2 chars
called by s or z

sab   = move to ab instance
;     = go to next match
3;    = go to 3rd match
C-o   = go to starting point
not working :
3dzqt = delete up to the third instance of "qt"
yszxy] = surround in brackets up to xy
gUz\}  = upper-case the text from the cursor until the next instance of the literal text \}
