#!/bin/sh

set -Ceux

sudo apt-get update -qq
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
sudo apt-get install -y \
    automake \
    wget \
    curl \
    git \
    zsh \
    build-essential \
    libncurses5-dev \
    pkg-config \
    libevent-dev \
    byacc \
    file \
    tree \
    neofetch \
    silversearcher-ag

neofetch

chsh -s $(which zsh)

for s in `ls ./ubuntu/*.sh`; do
  sh $s
done

for s in ".vim" ".zshrc" ".tigrc" ".tmux.conf" ".gitconfig" ".czrc" ".ideavimrc"; do
  ln -sfnv $PWD/$s       $HOME/$s
done
ln -sfnv $PWD/starship.toml $HOME/.config/starship.toml

if cat $HOME/.bashrc | grep 'export PATH=\$HOME/bin:\$PATH' >/dev/null 2>&1; then
  :
else
  echo "export PATH=\$HOME/bin:\$PATH" >> $HOME/.bashrc
fi
