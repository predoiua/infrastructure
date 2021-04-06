

# Vim

## Open file

FZF:
<C-p>  :Files ( ctrl n - p ) :Files! = open fzf in full win
<C-h> :History  ??
<Leader>; :Buffers

Open file:
C-v = open in vertical split
C-x = horizontal split

NERDTree:
m ( node modify ) = to move selected file
F7 - 


## Search / Move in file

EasyMotion
<leader>h j k l = search forward/backward/up/down
<leader>f = move to char
<leader>s = 2 char search

<leader>/ = search + key move
/ = ins search + TAB(next) + CTRL-j (page)

## Nice
:so % " source open file

" Open nerd tree at the current file or close nerd tree if pressed again.
nnoremap <silent> <expr> <F6>      g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"

