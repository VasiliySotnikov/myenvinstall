#!/bin/bash

# set a simlink to .vimrc
ln -s ~/.vim/.vimrc ~/.vimrc

# setup all plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#git clone https://github.com/rdnetto/YCM-Generator.git ~/.vim/bundle/
vim +PluginInstall +qall
#cd ~/.vim/bundle/YouCompleteMe
#./install.py --clang-completer


## setup system libraries for auto completion
#cd ~/.vim/bundle/YCM-Generator
#echo | cpp -x c++ -Wp,-v 2>&1 | grep "^ " > incllist
#sed "s/ //" incllist | sed "s/\(.*\)/    '\1',/" | sed "/\//i\    '-isystem'," > incllistm
#sed -i "/^flags \= \[/r incllistm"  template.py
#rm incllist incllistm
