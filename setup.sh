#!/bin/sh

cd $HOME

sudo aptitude install -y curl build-essential libssl-dev
sudo aptitude install -y ssh
sudo aptitude install -y zsh
sudo aptitude install -y vim vim-gtk vim-athena vim-gnome
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
sudo aptitude install -y mercurial

# change login shell to zsh
sudo chsh -s `which zsh` $USER

#zsh antigen
mkdir -p $HOME/.zsh
DIR=$HOME/.zsh/antigen
REPO=https://github.com/zsh-users/antigen.git
if [ ! -d $DIR ]; then
    git clone $REPO $DIR
fi

ln -s $HOME/dotfiles/zsh/zshrc .zshrc
ln -s $HOME/dotfiles/zsh/zprofile .zprofile
ln -s $HOME/dotfiles/zsh/zshenv .zshenv

#vim
ln -s $HOME/dotfiles/vim .vim
ln -s $HOME/dotfiles/vim/vimrc .vimrc

#git config
cat $HOME/dotfiles/git/git_config >> $HOME/.gitconfig

#tmux
ln -s $HOME/dotfiles/tmux/tmux.conf .tmux.conf
ln -s $HOME/dotfiles/tmux/tmux-powerlinerc .tmux-powerlinerc

#nodejs
git clone https://github.com/creationix/nvm.git $HOME/.nvm

# rbenv
git clone https://github.com/sstephenson/rbenv $HOME/.rbenv
mkdir $HOME/.rbenv/plugins
cd $HOME/.rbenv/plugins
git clone https://github.com/sstephenson/ruby-build

