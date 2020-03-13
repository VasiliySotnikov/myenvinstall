#!/bin/bash
set -e

mkdir -p $HOME/scratch && cd $HOME/scratch

git clone https://github.com/vim/vim.git || true
cd vim
git pull

make distclean

#PYCFG=$(dpkg -S "*python3*config.c" | sed "s/.*:\ \(\/.*\)config\.c/\1/")

./configure --with-features=huge --enable-multibyte --enable-rubyinterp=yes \
    --enable-python3interp=yes --enable-perlinterp=yes --enable-luainterp=yes \
    --enable-gui=gtk2 --enable-cscope --prefix=$HOME/local

#make VIMRUNTIMEDIR=$HOME/local/share/vim/vim82 -j5
make -j6
make install
