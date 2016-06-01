DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

install:
	@sudo apt-get update
	@sudo apt-get install -y build-essential
	@sudo apt-get install -y curl
	@sudo apt-get install -y wget
	@sudo apt-get install -y gawk
	@sudo apt-get install -y zsh
	@sudo apt-get install -y gnome-terminal
	@sudo apt-get install -y silversearcher-ag
	@sudo apt-get install -y fcitx-mozc
	@sudo chsh -s `which zsh` $(USER)
	@sh -x -e $(DOTPATH)/bin/build.sh tmux/tmux \
	"pkg-config libevent-dev libncurses5-dev xsel automake" ""
	@sh -x -e $(DOTPATH)/bin/build.sh vim/vim \
	"gettext libncurses5-dev libacl1-dev libgpm-dev libxmu-dev libgtk2.0-dev libxpm-dev libncurses5-dev libperl-dev python-dev python3-dev ruby-dev lua5.2 liblua5.2-dev exuberant-ctags" \
	" --with-features=huge --enable-gui=gtk2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing --enable-multibyte"
	@sh -x -e $(DOTPATH)/bin/build.sh jonas/tig \
	"libncurses5-dev" ""
