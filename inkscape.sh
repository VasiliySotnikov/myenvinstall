#!/bin/bash

set -e
mkdir -p $HOME/scratch && cd $HOME/scratch

git clone https://github.com/textext/textext.git || true
cd textext
git pull

python2 setup.py
