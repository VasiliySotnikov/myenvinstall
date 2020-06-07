#!/bin/bash
set -e

curl -sL install-node.now.sh/lts | bash -s -- --prefix=$HOME/local
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
npm i -g bash-language-server
pip3 install --user fortran-language-server
