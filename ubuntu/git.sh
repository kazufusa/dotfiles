#!/bin/sh

set -Ceux
export DEBIAN_FRONTEND=noninteractive
sudo sudo apt-get update
sudo -E apt-get install -y git dh-autoreconf libcurl4-gnutls-dev libexpat1-dev gettext libz-dev libssl-dev

if [ ! -d $HOME/src/github.com/git/git ]; then
  git clone --depth 1 https://github.com/git/git $HOME/src/github.com/git/git
fi
cd $HOME/src/github.com/git/git
git fetch
git checkout -f $(git describe --tags --abbrev=0)

make configure
./configure --prefix=$HOME
make all -j 4
make install
