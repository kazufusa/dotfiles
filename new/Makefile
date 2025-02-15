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
	bash ./scripts/brew.sh

install:
	bash -c 'eval "$$($(HOMEBREW_HOME)/bin/brew shellenv)" && stow -d . -t ~ zsh tmux vim nvim git sheldon bin'

.PHONY: all preparation brew install
