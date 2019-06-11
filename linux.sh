#!/bin/bash

set -eux

if [ "$SHELL_PLATFORM" != 'linux' ]; then
  exit 0
fi

# sudo apt-get update
# sudo apt-get install -y build-essential
# sudo apt-get install -y curl
# sudo apt-get install -y wget
# sudo apt-get install -y gawk
# # sudo apt-get install -y zsh
# sudo apt-get install -y gnome-terminal
# sudo apt-get install -y silversearcher-ag
# sudo apt-get install -y jq
# sudo apt-get install -y chromium-browser
# sudo apt-get install -y w3m
# # sudo chsh -s `which zsh` $USER
sh -eux $DOTPATH/bin/build.sh tmux/tmux \
"pkg-config libevent-dev libncurses5-dev xsel automake" ""
# LDFLAGS="-Wl,-rpath=$(pyenv root)/versions/$(pyenv global)/lib " \
sh -eux $DOTPATH/bin/build.sh vim/vim \
"gettext libncurses5-dev libacl1-dev libgpm-dev libxmu-dev libgtk2.0-dev libxpm-dev libncurses5-dev libperl-dev python-dev python3-dev ruby-dev lua5.2 liblua5.2-dev exuberant-ctags" \
" --with-features=huge --enable-gui=gtk2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing --enable-multibyte"
sh -eux $DOTPATH/bin/build.sh jonas/tig \
"libncursesw5-dev" "--enable-widec --with-ncursesw LDFLAGS=-L/usr/local/ncursesw-5.9/lib CFLAGS=-I/usr/local/ncursesw-5.9/include"
