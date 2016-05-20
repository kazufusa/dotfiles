DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

deploy:
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

install:
	@sh -x -e $(DOTPATH)/bin/build.sh tmux/tmux \
	"pkg-config libevent-dev libncurses5-dev xsel automake" ""
	@sh -x -e $(DOTPATH)/bin/build.sh vim/vim \
	"gettext libncurses5-dev libacl1-dev libgpm-dev libxmu-dev libgtk2.0-dev libxpm-dev libncurses5-dev libperl-dev python-dev python3-dev ruby-dev lua5.2 liblua5.2-dev exuberant-ctags" \
	" --with-features=huge --enable-gui=gtk2 --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-luainterp --enable-fail-if-missing"
	@sh -x -e $(DOTPATH)/bin/build.sh jonas/tig \
	"libncurses5-dev" ""
