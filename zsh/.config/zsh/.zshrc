##############################################################################
# homebrew
##############################################################################

if [[ "$(uname)" == 'Darwin' ]]; then
 HOMEBREW_HOME='/opt/homebrew'
else
 HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
fi

eval "$($HOMEBREW_HOME/bin/brew shellenv)"

##############################################################################
# homebrew
##############################################################################

# sheldon
eval "$(sheldon source)"

##############################################################################
# env
##############################################################################

export XDG_CONFIG_HOME=${HOME}/.config
export SHELL=$(which zsh)
if [ -d ~/Dropbox/dotfiles ]; then
  export HISTFILE=~/Dropbox/dotfiles/.histfile
else
  export HISTFILE=$ZDOTDIR/.histfile
fi
export HISTSIZE=50000
export SAVEHIST=10000000
export GPG_TTY=$(tty)
export TERM=screen-256color
export FZF_DEFAULT_OPTS='--layout=reverse --border --exit-0'
export LC_ALL=en_US.UTF-8

##############################################################################
# PATH
##############################################################################
export PATH="$HOME/bin:$PATH"
if type "zoxide" > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if type "mise" > /dev/null 2>&1; then
  eval "$(mise activate zsh)"
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

# AUTO_CDの対象に ~ と上位ディレクトリを加える
cdpath=(~ ..)

##############################################################################
# options
##############################################################################
setopt nolistbeep
setopt correct
setopt list_packed

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep

# フローコントロールを無効にする
setopt no_flow_control

# Ctrl+Dでzshを終了しない
setopt ignore_eof

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# 高機能なワイルドカード展開を使用する
setopt extended_glob
setopt share_history           # 履歴を他のシェルとリアルタイム共有する
setopt hist_ignore_all_dups    # 同じコマンドをhistoryに残さない
setopt hist_ignore_space       # historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks      # historyに保存するときに余分なスペースを削除する
setopt hist_save_no_dups       # 重複するコマンドが保存されるとき、古い方を削除する
setopt inc_append_history      # 実行時に履歴をファイルにに追加していく

# ZIM CONFIGURATION {{{

setopt PROMPT_SUBST
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

# }}}

##############################################################################
# Aliases
##############################################################################
alias ls='exa --classify --icons -h --reverse --git'
alias l=ll
alias la='ll -a'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias h='sudo shutdown -h'
alias r='sudo shutdown -r'
alias cd="z"

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
# finalize
##############################################################################
autoload -Uz compinit && compinit

source $XDG_CONFIG_HOME/zsh/custom.zsh >/dev/null 2>&1 || :
