#!/bin/bash

set -eux

if [ "$SHELL_PLATFORM" != 'linux' ]; then
  exit 0
fi

sh -eux $DOTPATH/bin/build.sh vim/vim \
"gettext libncurses5-dev libacl1-dev libgpm-dev libxmu-dev libgtk2.0-dev libxpm-dev libncurses5-dev libperl-dev python-dev python3-dev ruby-dev lua5.2 liblua5.2-dev exuberant-ctags" \
" --with-features=huge --enable-gui=gtk2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing --enable-multibyte"
