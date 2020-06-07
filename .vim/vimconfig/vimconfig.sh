#!/bin/bash
set -e

# setup all plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true
vim +PluginInstall +PluginUpdate +qall

./installYCM.sh
