#!/bin/sh

set -Ceux

if [ "$(uname)" == 'Linux' ]; then
  sudo apt-get update
  sudo apt-get upgrade -y
  sudo apt-get install -y curl make build-essential git zsh locales 
  sudo chsh -s /bin/zsh
  sudo locale-gen en_US.UTF-8
fi
