##############################################################################
# Homebrew
##############################################################################
if [[ "$(uname)" == 'Darwin' ]]; then
  HOMEBREW_HOME='/opt/homebrew'
else
  HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
fi

eval "$($HOMEBREW_HOME/bin/brew shellenv)"

##############################################################################
# Environment variables
##############################################################################
export EDITOR=nvim
export VISUAL=nvim

export XDG_CONFIG_HOME=${HOME}/.config
export SHELL=$(which zsh)
export FORCE_COLOR=1
export GPG_TTY=$(tty)
export TERM=screen-256color
export LC_ALL=en_US.UTF-8
export FZF_DEFAULT_OPTS='--layout=reverse --border --exit-0'

##############################################################################
# PATH
##############################################################################
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/bin:~/Dropbox/forpath:$PATH
