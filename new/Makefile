UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	HOMEBREW_HOME := /home/linuxbrew/.linuxbrew
else ifeq ($(UNAME_S),Darwin)
	HOMEBREW_HOME := /opt/homebrew
endif

all: preparation brew install

preparation:
	bash ./scripts/preparation.sh

brew:
	bash ./scripts/brew.sh || :

install:
	bash -c 'eval "$$($(HOMEBREW_HOME)/bin/brew shellenv)" && stow --override=. -d . -t ~ zsh tmux vim nvim git sheldon bin'
	curl -fLo ~/.config/vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim || :
	git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm || :


.PHONY: all preparation brew install
