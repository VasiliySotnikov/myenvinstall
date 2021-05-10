#!/bin/bash

set -e
mkdir -p $HOME/scratch && cd $HOME/scratch

git clone https://github.com/textext/textext.git || true
cd textext
git pull

cp ~/scratch/myenvinstall/default_packages.tex ./textext/default_packages.tex

python3 setup.py
