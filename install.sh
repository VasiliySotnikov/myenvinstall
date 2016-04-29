#!/bin/bash

#mkdir -p ~/.vim
#mkdir -p ~/.dircolors
#mkdir -p ~/.config/xfce4/terminal

test -f ~/.bashrc && mv ~/.bashrc ~/.bashrc_initial
cp .bashrc ~/.bashrc
cp -r --parents .vim ~/
cp -r --parents .dircolors ~/
if [ $COLORTERM == "xfce4-terminal" ]; then
    cp -r --parents .config/xfce4/terminal/terminalrc ~/
elif [ $COLORTERM == "gnome-terminal" ]; then
    ./gnomesolarized.sh
fi

cd ~/.vim/vimconfig/
./install.sh
