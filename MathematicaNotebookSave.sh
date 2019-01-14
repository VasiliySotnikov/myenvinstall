#!/bin/bash

set -e
mkdir -p $HOME/scratch && cd $HOME/scratch

git clone  https://github.com/VasiliySotnikov/mathematica-autobackup.git || true
cd mathematica-autobackup
git pull

make install
