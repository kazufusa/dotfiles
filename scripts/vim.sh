#!/bin/sh

set -Ceux

ismac && exit

export PATH=$(echo $PATH | sed -r 's/\/home\/linuxbrew[^:]*://g')

sudo apt-get update -qq
sudo apt-get install -y gettext libncurses5-dev libacl1-dev libgpm-dev libxmu-dev libgtk2.0-dev libxpm-dev libncurses5-dev libperl-dev python-dev python3-dev ruby-dev lua5.2 liblua5.2-dev exuberant-ctags

sudo apt-get install -y python3-pip
# sudo python3 -m pip install pynvim

if [ ! -d $HOME/src/github.com/vim/vim ]; then
  git clone https://github.com/vim/vim $HOME/src/github.com/vim/vim
fi
cd $HOME/src/github.com/vim/vim
git fetch
git checkout -f $(git describe --tags --abbrev=0)
git show
read -p "ok? (y/N): " yn; case "$yn" in [yY]*) echo hello;; *) echo "abort";; esac

[ -e ./autogen.sh ] && sh ./autogen.sh
./configure --prefix=$HOME \
  --with-features=huge \
  --enable-gui=gtk2 \
  --enable-perlinterp \
  --enable-python3interp \
  --enable-rubyinterp \
  --enable-luainterp \
  --enable-fail-if-missing \
  --enable-multibyte \
  && make -j 4 && make install
