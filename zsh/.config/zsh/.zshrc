##############################################################################
# Plugin manager
##############################################################################
_eval_cache "${XDG_CACHE_HOME:-$HOME/.cache}/sheldon/source.zsh" \
  "${XDG_CONFIG_HOME:-$HOME/.config}/sheldon/plugins.toml" \
  sheldon source

##############################################################################
# History
##############################################################################
if [ -d ~/Dropbox/dotfiles ]; then
  export HISTFILE=~/Dropbox/dotfiles/.histfile
elif [[ "$TERM_PROGRAM" == "vscode" ]]; then
  export HISTFILE=/dev/null
else
  export HISTFILE=$ZDOTDIR/.histfile
fi
export HISTSIZE=50000
export SAVEHIST=10000000

setopt extended_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt inc_append_history

##############################################################################
# Shell options
##############################################################################
setopt no_beep
setopt no_flow_control
setopt ignore_eof
setopt interactive_comments
setopt print_eight_bit
setopt correct
setopt list_packed
setopt extended_glob
setopt prompt_subst

# Directory
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
cdpath=(~ ..)

##############################################################################
# Key bindings
##############################################################################
bindkey -e
WORDCHARS=${WORDCHARS//[\/]}

# zsh-history-substring-search
zmodload -F zsh/terminfo +p:terminfo
for key ('^[[A' '^P' ${terminfo[kcuu1]}) bindkey ${key} history-substring-search-up
for key ('^[[B' '^N' ${terminfo[kcud1]}) bindkey ${key} history-substring-search-down
for key ('k') bindkey -M vicmd ${key} history-substring-search-up
for key ('j') bindkey -M vicmd ${key} history-substring-search-down
unset key

##############################################################################
# Tools
##############################################################################
if type "zoxide" > /dev/null 2>&1; then
  eval "$(zoxide init zsh --cmd cd)"
fi

if type "mise" > /dev/null 2>&1; then
  zsh-defer eval "$(mise activate zsh)"
fi

##############################################################################
# cdr
##############################################################################
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default true
zstyle ':chpwd:*' recent-dirs-insert true
zstyle ':chpwd:*' recent-dirs-file "$ZDOTDIR"/chpwd-recent-dirs

##############################################################################
# Plugin configuration
##############################################################################
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

##############################################################################
# Aliases
##############################################################################
alias ls='exa --classify --icons -h --reverse --git'
alias l=ll
alias la='ll -a'
alias cp='cp -i'
alias mv='mv -i'
alias h='sudo shutdown -h'
alias r='sudo shutdown -r'
alias vim='nvim'

##############################################################################
# Functions
##############################################################################
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

if [[ $(uname -a) =~ Linux ]]; then
  function open() { cmd.exe /c start $(wslpath -w $1) }
fi

##############################################################################
# Completions
##############################################################################
fpath=("$XDG_CONFIG_HOME/zsh/completions" $fpath)
autoload -U compinit && compinit -C

##############################################################################
# Finalize
##############################################################################
source $XDG_CONFIG_HOME/zsh/custom.zsh >/dev/null 2>&1 || :
