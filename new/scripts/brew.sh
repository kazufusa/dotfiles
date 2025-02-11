#!/bin/sh

set -Ceux

if [ "$(uname)" == 'Darwin' ]; then
  export HOMEBREW_HOME='/opt/homebrew'
else
  apt-get update
  apt-get upgrade
  apt-get install -y curl make build-essential git zsh
  chsh -s /bin/zsh
  export HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
fi

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$($HOMEBREW_HOME/bin/brew shellenv)"
brew bundle --file ./Brewfile
