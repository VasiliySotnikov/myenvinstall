#!/bin/bash
set -e

cd ~/.vim/bundle/YouCompleteMe
git pull
git submodule update --init --recursive
make distclean
python3 ./install.py --clang-completer
