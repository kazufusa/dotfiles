#!/bin/bash
set -eux

if [ "$SHELL_PLATFORM" != 'osx' ]; then
  exit 0
fi

if ! type brew >/dev/null 2>&1; then
  exit
fi

# installs
echo installs
brew install tmux
brew install reattach-to-user-namespace
brew install lua
brew install vim --with-lua
brew install gawk
brew install wget
brew install ag
brew install zsh
[[ `cat /etc/shells | grep /usr/local/bin/zsh` ]] || sudo sh -c "echo /usr/local/bin/zsh >> /etc/shells"
[[ `echo $SHELL | grep "zsh"` ]] || sudo chsh -s /usr/local/bin/zsh $USER
brew install git
brew install tig
brew install coreutils
