#!/bin/sh
sudo aptitude install -y ssh
sudo aptitude install -y zsh
sudo aptitude install -y autojump
sudo aptitude install -y vim
#sudo aptitude install -y linux-headers-$(uname -r)
sudo aptitude install -y build-essential
sudo aptitude install -y zlib1g-dev
sudo aptitude install -y libbz2-dev
sudo aptitude install -y zip
sudo aptitude install -y tree
sudo aptitude install -y terminator
sudo aptitude install -y git
sudo aptitude install -y ttf-inconsolata

# change login shell
sudo chsh -s /bin/zsh $USER

# terminator configuration
mkdir -p $HOME/.config/terminator/
cp $HOME/dotfiles/configs/terminator_config $HOME/.config/terminator/config
if [ -e /etc/xdg/lxsession/Lubuntu/autostart ]; then
    sudo sh -c "echo '@terminator -l workspace' >> /etc/xdg/lxsession/Lubuntu/autostart"
fi

