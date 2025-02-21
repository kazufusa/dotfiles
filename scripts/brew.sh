#!/bin/s

set -Ceux

if !(type "brew" > /dev/null 2>&1); then
  if [ "$(uname)" == 'Darwin' ]; then
    export HOMEBREW_HOME='/opt/homebrew'
  else
    export HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
  fi

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi

brew bundle --file ./Brewfile
