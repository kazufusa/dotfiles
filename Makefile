UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	HOMEBREW_HOME := /home/linuxbrew/.linuxbrew
else ifeq ($(UNAME_S),Darwin)
	HOMEBREW_HOME := /opt/homebrew
endif

all: preparation brew install vim

preparation:
	bash ./scripts/preparation.sh

brew:
	bash ./scripts/brew.sh || :

uninstall:
	bash -c 'eval "$$($(HOMEBREW_HOME)/bin/brew shellenv)" && STOW_DIR=$$(dirname $$(dirname $$(realpath ~/.zshenv))) && stow -d $$STOW_DIR -t ~ -D zsh tmux vim nvim git sheldon bin'

install:
	bash -c 'eval "$$($(HOMEBREW_HOME)/bin/brew shellenv)" && stow -d . -t ~ zsh tmux vim nvim git sheldon bin'
	curl -fLo ~/.config/vim/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim || :
	test -d ~/.config/tmux/plugins/tpm || git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

vim:
	bash ./scripts/vim.sh

.PHONY: all preparation brew install uninstall vim
