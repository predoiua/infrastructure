# fasd
## Usage in dotfiles
eval "$(fasd --init auto)"
file="$(fasd -Rfl "$1" | fzf -1 -0 --no-sort +m)" && vim "${file}" || return 1

fasd -Rfl # R=Reverse order, f=Files l=only path

z() {
   [ $# -gt 0 ] && fasd_cd -d "$*" && return
   local dir
   dir="$(fasd -Rdl "$1" | fzf -1 -0 --no-sort +m)" && cd "${dir}" || return 1
}

## scenario

create a folder structure
~~~ bash
mkdir -p zombies/aliens
mkdir -p zuck/aliens
touch zuck/aliens/ship.txt
~~~


~~~ bash
fasd -a     # a = all. print last used file and dirs
fasd -si    # search intercative. will give a prompt to select a file/dir
fasd -d                 # d = dir. print last used dirs
fasd_cd -d zo           # cd in zombies dir
fasd_cd -d zu           # cd in zuck dir
fasd_cd -d zu al        # cd in zuck/aliens dir
fasd -f -e vi zu al sh  # open file zuck\aliens\ship.txt with vi
~~~

## fasd paramaters
~~~ bash
fasd --help
alias a='fasd -a'        # any
alias s='fasd -si'       # show, search, select
alias d='fasd -d'        # directory
alias f='fasd -f'        # file
alias sd='fasd -sid'     # interactive directory selection
alias sf='fasd -sif'     # interactive file selection
alias z='fasd_cd -d'     # cd, same functionality as j in autojump
alias zz='fasd_cd -d -i' # cd with interactive selection
~~~