#!/bin/bash

# setup all plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#setup vim-latex
cd ~/.vim
tar xf vim-latex-1.9.0.tar.gz
cp -R vim-latex-1.9.0/. ./
rm -rf vim-latex-1.9.0
rm vim-latex-1.9.0.tar.gz

./installYCM.sh
./setupYCMGenerator.sh
