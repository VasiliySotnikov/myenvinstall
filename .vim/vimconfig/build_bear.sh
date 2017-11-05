#!/bin/bash

# install also a tool to generate compile database
cd $HOME/scratch
rm -rf Bear
git clone https://github.com/rizsotto/Bear.git
cd Bear
git pull
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=$HOME/local ../ && make all && make install
