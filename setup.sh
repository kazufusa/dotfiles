#!/bin/sh
#link dotfiles
cd $(dirname $0)
for dotfile in .?*
do
    if [ $dotfile != '..' ]  && [ $dotfile != '.git' ] && [ $dotfile != '.gitignore' ]
    then
        ln -fs "$PWD/$dotfile" $HOME/$dotfile
    fi
done

#zsh antigen
mkdir -p $HOME/.zsh
DIR=$HOME/.zsh/antigen
REPO=https://github.com/zsh-users/antigen.git
if [ ! -d $DIR ]; then
    git clone $REPO $DIR
fi

#vim neobundle
mkdir -p $HOME/.vim/bundle
DIR=$HOME/.vim/bundle/neobundle
REPO=https://github.com/Shougo/neobundle.vim
if [ ! -d $DIR ]; then
    git clone $REPO $DIR
fi
