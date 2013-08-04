#!/bin/sh
sudo aptitude install -y ssh
sudo aptitude install -y zsh
sudo aptitude install -y vim vim-gtk vim-athena vim-gnome
#sudo aptitude install -y linux-headers-$(uname -r)
sudo aptitude install -y build-essential
sudo aptitude install -y zlib1g-dev
sudo aptitude install -y libbz2-dev
sudo aptitude install -y zip
sudo aptitude install -y tree
sudo aptitude install -y terminator
sudo aptitude install -y git
sudo aptitude install -y ttf-inconsolata
sudo aptitude install -y ibus-mozc
sudo aptitude install -y figlet
sudo aptitude install -y clang libclang-dev
sudo aptitude install -y exuberant-ctags
sudo aptitude install -y w3m

# change login shell to zsh
chsh -s /bin/zsh $USER

# terminator configuration
mkdir -p $HOME/.config/terminator/
mv $HOME/.config/terminator/config $HOME/.config/terminator/config.default
cp $HOME/dotfiles/configfiles/terminator_config $HOME/.config/terminator/config

mkdir -p $HOME/.config/autostart
cp $HOME/dotfiles/configfiles/terminator.desktop $HOME/.config/autostart/
