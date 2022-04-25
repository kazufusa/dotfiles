DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml .gitignore
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

install:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	ln -sfnv $(abspath zsh) $(HOME)/.config/zsh
	mkdir -p $(HOME)/bin
	cp ./bin/* $(HOME)/bin/

brew:
	uname -a | grep Darwin
	command -v brew >/dev/null || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew tap homebrew/cask-fonts
	brew install --cask google-chrome
	brew install zsh fzf tmux tig vim neofetch tree htop bat ag bottom ghq git font-hackgen-nerd coreutils exa zoxide wget w3m iproute2mac gh
	[ -e ~/.fzf.zsh ] || $(brew --prefix)/opt/fzf/install --all

tmux:
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm 2>/dev/null|| :
	@echo "Press prefix + I (capital i, as in Install) to fetch the plugin."

.PHONY: install brew
