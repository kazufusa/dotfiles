#!/bin/sh

set -Ceux

if [ "$(uname)" == 'Linux' ]; then
  apt-get update
  apt-get upgrade -y
  apt-get install -y curl make build-essential git zsh locales
  chsh -s /bin/zsh
  locale-gen en_US.utf-8
fi
