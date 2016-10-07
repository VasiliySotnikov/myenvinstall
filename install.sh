#!/bin/bash

#mkdir -p ~/.vim
#mkdir -p ~/.dircolors
#mkdir -p ~/.config/xfce4/terminal

test -f ~/.bashrc && mv ~/.bashrc ~/.bashrc_initial
cp .bashrc ~/.bashrc
cp -r --parents .vim ~/
cp -r --parents .dircolors ~/
if [[ $(ps -h -o comm -p $PPID) == xfce4* ]]; then
    cp -r --parents .config/xfce4/terminal/terminalrc ~/
elif [ $(ps -h -o comm -p $PPID) == gnome* ]; then
    ./gnomesolarized.sh
fi

cd ~/.vim/vimconfig/
./vimconfig.sh
