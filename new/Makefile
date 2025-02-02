init:
	bash ./scripts/init.sh

brew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew bundle --file ./Brewfile

install:
	stow git tmux zsh nvim vim

.PHONY: brew install
