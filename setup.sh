#!/bin/sh

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

#vim template
mkdir -p $HOME/.vim/template
for templatefile in template.*
do
    ln -fs "$PWD/$templatefile" $HOME/.vim/template/$templatefile
done

#git config
cat $HOME/dotfiles/configfiles/git_config >> $HOME/.gitconfig
