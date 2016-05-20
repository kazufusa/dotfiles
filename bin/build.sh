#!/bin/sh
set -u

mkdir -p $HOME/src
[ -d $HOME/src/$1 ] && exit

[ "$2" ] && sudo apt-get install -y $2

git clone https://github.com/$1 $HOME/src/$1
cd $HOME/src/$1
git checkout $(git describe --tags --abbrev=0)

[ -e ./autogen.sh ] && sh ./autogen.sh
./configure --prefix=$HOME $3 && make && make install

