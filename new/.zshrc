# env

export ZDOTDIR=$pwd
exit

# homebrew

if [[ "$(uname)" == 'Darwin' ]]; then
 HOMEBREW_HOME='/opt/homebrew'
else
 HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
fi

eval "$($HOMEBREW_HOME/bin/brew shellenv)"

eval "$(sheldon --config-file $ZDOTDIR/sheldon.toml source)"

type fzf && source <(fzf --zsh)

exit

# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}

# -----------------
# Zim configuration
# -----------------

# Use degit instead of git as the default tool to install and update modules.
#zstyle ':zim:zmodule' use 'degit'

# --------------------
# Module configuration
# --------------------

#
# git
#

# Set a custom prefix for the generated aliases. The default prefix is 'G'.
#zstyle ':zim:git' aliases-prefix 'g'

#
# input
#

# Append `../` to your input for each `.` you type after an initial `..`
#zstyle ':zim:input' double-dot-expand yes

#
# termtitle
#

# Set a custom terminal title format using prompt expansion escape sequences.
# See http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Simple-Prompt-Escapes
# If none is provided, the default '%n@%m: %~' is used.
#zstyle ':zim:termtitle' format '%1~'

#
# zsh-autosuggestions
#

# Disable automatic widget re-binding on each precmd. This can be set when
# zsh-users/zsh-autosuggestions is the last module in your ~/.zimrc.
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Customize the style that the suggestions are shown with.
# See https://github.com/zsh-users/zsh-autosuggestions/blob/master/README.md#suggestion-highlight-style
#ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

#
# zsh-syntax-highlighting
#

# Set what highlighters will be used.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters.md
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize the main highlighter styles.
# See https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md#how-to-tweak-it
#typeset -A ZSH_HIGHLIGHT_STYLES
#ZSH_HIGHLIGHT_STYLES[comment]='fg=242'

# ------------------
# Initialize modules
# ------------------

ZIM_HOME=${ZDOTDIR:-${HOME}}/.zim
# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  if (( ${+commands[curl]} )); then
    curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  else
    mkdir -p ${ZIM_HOME} && wget -nv -O ${ZIM_HOME}/zimfw.zsh \
        https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
  fi
fi
# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi
# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ------------------------------
# Post-init module configuration
# ------------------------------

#
# zsh-history-substring-search
#

zmodload -F zsh/terminfo +p:terminfo
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key
# }}} End configuration added by Zim install

# PATH {{{
PATH=$HOME/dotfiles/bin:$PATH

mkdir -p $HOME/bin
if [ -d $HOME/Dropbox/forpath ]; then
  PATH=$HOME/bin:$HOME/Dropbox/forpath:$PATH
else
  PATH=$HOME/bin:$PATH
fi
# }}}

# cdrを有効にして設定する {{{
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-insert true
zstyle ':chpwd:*' recent-dirs-file "$ZDOTDIR"/chpwd-recent-dirs

# AUTO_CDの対象に ~ と上位ディレクトリを加える
cdpath=(~ ..)
# }}}

# ZSH options {{{
setopt no_beep
setopt nolistbeep
setopt correct
setopt list_packed
# }}}

# Environment variables {{{
# SHELL
export SHELL=$(which zsh)

# history
if [ -d ~/Dropbox/dotfiles ]; then
  export HISTFILE=~/Dropbox/dotfiles/.histfile
else
  export HISTFILE=$ZDOTDIR/.histfile
fi
export HISTSIZE=50000
export SAVEHIST=10000000

# GPG_TTY
export GPG_TTY=$(tty)

export TERM=screen-256color

# Go
export _GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$_GOROOT/bin:$PATH
export GO111MODULE=on

# Rust
if [ -f $HOME/.cargo/env ]; then
  source "$HOME/.cargo/env"
fi
# }}}

# Aliases {{{
alias ls='exa --classify --icons -h --reverse --git'
alias l=ll
alias la='ll -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias h='sudo shutdown -h'
alias r='sudo shutdown -r'

function repo(){
  ghq list | fzf --reverse +m -q "$1" \
    --preview "find $(ghq root)/{} -maxdepth 1 -iname 'readme.*' \
      | xargs bat --color=always --style=header,grid --line-range :80"
}

function ce() {
  local _cd=`type z >/dev/null 2>&1 && echo z || echo cd`
  if [ "$1" = "-" ]; then
    $_cd - >/dev/null
  else
    local _repo="$(repo $1)"
    [[ -n "${_repo}" ]] && $_cd "$(ghq root)/${_repo}"
  fi
}

function installgo() {
  if [ -d /usr/local/go$1 ]; then
    echo /usr/local/go$1 exists
  else
    sudo wget https://golang.org/dl/go$1.$2-$3.tar.gz -O - | tar -C /tmp -xzf -
    sudo mv /tmp/go /usr/local/go$1
  fi
}

if [[ $(uname -a) =~ Linux ]]; then
  function open() { cmd.exe /c start $(wslpath -w $1) }
fi
# }}}

# Etc {{{
# in vim, enable to map Ctrl-S to file saving
stty -ixon -ixoff

# zoxide {{{
if [ -x "$(command -v zoxide)" ]; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi
# }}}

# fzf for Mac {{{
if [[ $OSTYPE =~ darwin ]]; then
  if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh
  elif [ -x "$(command -v brew)" ]; then
    brew install fzf
    $(brew --prefix)/opt/fzf/install --all
    source ~/.fzf.zsh
  fi
fi
export FZF_DEFAULT_OPTS='--layout=reverse --border --exit-0'
# }}}

# zinit for Linux {{{
if [[ $(uname -a) =~ Linux ]]; then
  source ${ZDOTDIR}/.zshrc.linux
fi
# }}}

# homebrew@M1 Mac {{{
if [[ -d '/opt/homebrew' ]]; then
 HOMEBREW_HOME='/opt/homebrew'
 eval "$($HOMEBREW_HOME/bin/brew shellenv)"
fi
# }}}

if [ -e "$HOME/.bun" ]; then
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
fi

# }}}

autoload -Uz compinit && compinit
