#!/bin/bash
set -e

./install_coc_dependencies.sh

# setup all plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 2>/dev/null || (cd ~/.vim/bundle/Vundle.vim ; git pull)
vim +PluginInstall

vim +":call coc#util#install()"
vim +"CocInstall coc-cmake coc-python coc-clangd coc-json coc-rls"
vim -c "CocCommand clangd.install" t.cpp
