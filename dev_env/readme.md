
# set up a dev env on Linux based on tmux and nvim

# general

~~~bash
apt install git
# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# for tmux
apt install libevent ncurses 
apt install libevent-dev ncurses-dev build-essential bison pkg-config automake cmake

~~~

## tmux

~~~
cd /tmp
git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure --prefix=$HOME/.tmux
make && make install
cd -
~~~

## nvim

~~~bash
cd /git/study
git clone https://github.com/neovim/neovim.git
cd neovim
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.neovim install
~~~

# small things
## fzf
https://medium.com/@alexeysamoshkin

~~~bash
mkdir -p ~/git/study
cd !$
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
~~~
## bat
https://github.com/sharkdp/bat

~~~bash
cd ~/git/study
git clone https://github.com/sharkdp/bat && cd bat
cargo install --path . --locked
~~~

## rg

~~~bash
cd ~/git/study
git clone https://github.com/BurntSushi/ripgrep.git && cd ripgrep
cargo install --path . --locked
~~~
# config
create .inputrc from dottiles

export PATH=~/.tmux/bin:~/.neovim/bin:~/.cargo/bin:${PATH}

### nvim config
https://github.com/jakobwesthoff/nvim-from-scratch

~~~
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim_from_scratch
export NVIM_APPNAME=nvim_from_scratch
~~~

https://lazy.folke.io/installation
lazy.nvim
~~~
mkdir -p ~/.config/nvim/lua/plugins/
echo "return {}" > ~/.config/nvim/lua/plugins/init.lua
~~~
vi ~/.config/nvim/init.lua
vi ~/.config/nvim/lua/config/lazy.lua

colorscheme:
https://github.com/rebelot/kanagawa.nvim

nice collection. status:
https://github.com/nvim-mini/mini.nvim

file manager:
https://github.com/stevearc/oil.nvim

good default options:
kitstart.vim

check existing file structure to keep existing options
https://github.com/tpope/vim-sleuth

showkeys
https://github.com/nvzone/showkeys

treesitter
generic parser. 
https://github.com/nvim-treesitter/nvim-treesitter
:Inspect
:InspectTree
<CR>  <BACKSPACE> to select / de-select
= reformat
set expandtab
retab = fix tabs
retab! = tab to spaces

which-key
https://github.com/folke/which-key.nvim
<leader>? = show available key commands

fzf lua
https://github.com/ibhagwan/fzf-lua
"<leader>ff",
        desc="Find Files in project directory"
"<leader>fg",
        desc="Find by grepping in project directory"
"<leader>fc",
        desc="Find in neovim configuration"
"<leader>fh",
        desc = "[F]ind [H]elp",
"<leader>fk",
        desc = "[F]ind [K]eymaps",
"<leader>fb",
        desc = "[F]ind [B]uiltin FZF",
"<leader>fw",
        desc = "[F]ind current [W]ord",
"<leader>fW",
        desc = "[F]ind current [W]ORD",
"<leader>fd",
        desc = "[F]ind [D]iagnostics",
"<leader>fr",
        desc = "[F]ind [R]esume",
"<leader>fo",
        desc = "[F]ind [O]ld Files",
"<leader><leader>",
        desc = "[,] Find existing buffers",
"<leader>/",
        desc = "[/] Live grep the current buffer",

project.nvim
    use project root for fzf ff        

## motion easymotion
new plugin: leap.nvim
    <leader><leader>s for bidirectional search.
    <leader><leader>F for forward search.
    <leader><leader>B for backward search. 

## motion sneak
        github.com/justinmk/vim-sneak
        s{char}{char}
        ; to go to the next match (or s again, if s_next is enabled)
        3; to skip to the third match from the current position.
        ctrl-o or `` to go back to the starting point
        s<Enter> at any time to repeat the last Sneak-search
        S to search backwards.
        3dzqt to delete up to the third instance of "qt"
        yszxy] to surround in brackets up to xy =? 
        gUz\} to upper-case the text from the cursor until the next instance of the literal text \}s
jumplist = ?


LSP
        map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition"
        map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")
        map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

TMUX 
Plug 'roxma/vim-tmux-clipboard'
Plug 'christoomey/vim-tmux-navigator'
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },

Plug 'mhinz/vim-startify'             " Better start screen

# jose keys