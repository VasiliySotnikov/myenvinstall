#!/bin/bash

#mkdir -p ~/.vim
#mkdir -p ~/.dircolors
#mkdir -p ~/.config/xfce4/terminal

test -f ~/.bashrc && mv ~/.bashrc ~/.bashrc_initial
cp .bashrc ~/.bashrc
cp -r --parents .vim ~/
cp -r --parents .dircolors ~/
cp -r --parents .config/xfce4/terminal/terminalrc ~/

cd ~/.vim/vimconfig/
./install.sh
