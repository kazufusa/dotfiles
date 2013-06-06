#!/bin/sh

sudo aptitude install -y libssl-dev
sudo aptitude install -y curl

mkdir -p $HOME/.nvm
git clone git://github.com/creationix/nvm.git $HOME/.nvm
