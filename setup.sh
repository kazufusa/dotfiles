#!/bin/sh
#link dotfiles
cd $(dirname $0)
for dotfile in *
do
    if [ $dotfile != '..' ]  && [ $dotfile != '.git' ] && [ $dotfile != 'setup.sh' ]
    then
        if [ -e  $HOME/.$dotfile ]; then
            rm $HOME/.$dotfile
        fi
        ln -fs "$PWD/$dotfile" $HOME/.$dotfile
    fi
done

#zsh antigen
mkdir -p ~/.zsh
git clone https://github.com/zsh-users/antigen.git ~/.zsh/antigen

#vim neobundle
mkdir -p ~/.vim/bundle
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle
