#!/bin/sh

set -Ceux

if [ "$(uname)" == 'Linux' ]; then
  apt-get update
  apt-get upgrade -y
  apt-get install -y curl make build-essential git zsh
  chsh -s /bin/zsh
fi
