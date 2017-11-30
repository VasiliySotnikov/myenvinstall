#!/bin/bash

# setup all plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

#setup vim-latex
cd $HOME/.vim
tar xf vim-latex-1.9.0.tar.gz
cp -R vim-latex-1.9.0/. ./
rm -rf vim-latex-1.9.0
rm vim-latex-1.9.0.tar.gz

cd -
./installYCM.sh
./setupYCMGenerator.sh
./build_bear.sh
