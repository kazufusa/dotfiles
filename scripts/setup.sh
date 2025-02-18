#!/bin/bash

set -Ceux

if [ "$(uname)" == 'Linux' ]; then
  apt-get update
  apt-get upgrade -y
  apt-get install -y make git
fi

git clone https://github.com/kazufusa/dotfiles.git ~/src/github.com/kazufusa/dotfiles

cd ~/src/github.com/kazufusa/dotfiles/

make all
