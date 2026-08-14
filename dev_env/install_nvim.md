Will install it in ~/.local as recommended by ## XDG Base Directory Specification [#](https://specifications.freedesktop.org/basedir/latest/#index "Permalink")
XDG = X Desktop Group = standard for Linux Desktop

## nvim

Install from sources

As of 2026.06 - 0.11 it's working with treesitter. 012 not

~~~bash
cd /git/study
git clone https://github.com/neovim/neovim.git
cd neovim

#git checkout release-0.11   # not really...
git tag -l "v0.11*"                       # list only those tags
export TAG=v0.11.7
git checkout tags/${TAG} -b build-${TAG} # take tag as branh else DETACH HEAD  

mkdir -p ~/.local/opt/neovim_${TAG}
make distclean
make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=$HOME/.local/opt/neovim_${TAG}
make install

ln -sf ~/.local/opt/neovim_${TAG}/bin/nvim ~/.local/bin/nvim

readlink -f $(which nvim)
nvim --version
~~~


# cleanup


~~~bash
rm -rf ~/.local/share/nvim/*
~~~

