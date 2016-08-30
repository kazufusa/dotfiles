#------------------------------------------------------------------------------
# general
#------------------------------------------------------------------------------
## emucs binding
bindkey -e

# beep
setopt no_beep
setopt nolistbeep

# appearance
setopt no_check_jobs
setopt print_eight_bit
setopt list_packed
setopt correct

# operation
setopt auto_cd
setopt no_flow_control
setopt extended_glob

## completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

#------------------------------------------------------------------------------
# PATH
#------------------------------------------------------------------------------
if type brew > /dev/null 2>&1; then
  PATH=/usr/local/bin:$PATH
fi

if [ -d $HOME/Dropbox/forpath ]; then
  PATH=$HOME/bin:$HOME/Dropbox/forpath:$PATH
else
  PATH=$HOME/bin:$PATH
fi

## zsh config for hist file
if [ -d ~/Dropbox/dotfiles ]; then
  ZSH_CONFIG_PATH=~/Dropbox/dotfiles
else
  ZSH_CONFIG_PATH=~/.zsh
fi

if ! [ -d $ZSH_CONFIG_PATH ]; then
  mkdir -p $ZSH_CONFIG_PATH
fi

# you need `$git clone https://github.com/riywo/anyenv $HOME/.anyenv`
if [ -d $HOME/.anyenv ] ; then
  export PATH=$HOME/.anyenv/bin:$PATH
  eval "$(anyenv init -)"
else
  echo "anyenv is not installed. Please execute"
  echo "'git clone https://github.com/riywo/anyenv $HOME/.anyenv'"
  echo "'git clone https://github.com/znz/anyenv-update.git $HOME/.anyenv/plugins/anyenv-update'"
  echo ""
fi

#------------------------------------------------------------------------------
# color (check: where color)
#------------------------------------------------------------------------------
export TERM=screen-256color
#autoload -Uz colors; colors
#LS_COLORS='di=01;36:ln=01;35:ex=01;31:'
#LS_COLORS+='*.c=01;35:*.cpp=01;35:*.js=01;35:*.json=01;35:*.hs=01;35:*.py=01;35:*.pl=01;35:'
#LS_COLORS+='*.tex=01;35:*.csv=01;35:*.r=01;35:*.R=01;35:*.txt=01;35:*.sty=01;35:*.coffee=01;35:*.class=01;35:*.java=01;35:*.less=01;35:*.css=01;35:'
#LS_COLORS+='*.jpg=01;33:*.png=01;33:*.bmp=01;33:*.JPG=01;33:*.PNG=01;33:*.BMP=01;33:'
#LS_COLORS+='*.gz=01;34:*.tar=01;34:*.zip=01;34:'
#LS_COLORS+='*.pdf=01;32:*makefile=01;32:*.html=01;32:'
#export LS_COLORS # doesn't work in Mac
#export LSCOLORS=gxfxcxdxbxegedabagacad
#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#------------------------------------------------------------------------------
# history
#------------------------------------------------------------------------------
HISTFILE=$ZSH_CONFIG_PATH/.histfile
HISTSIZE=10000000
SAVEHIST=10000000
setopt append_history
setopt extended_history
setopt hist_ignore_dups
setopt hist_no_store
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_ignore_space
setopt share_history

#------------------------------------------------------------------------------
# Aliases
#------------------------------------------------------------------------------
alias ..="cd ../"
alias l='ls -al'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias h='sudo shutdown -h'
alias r='sudo shutdown -r'
alias ungzip='gzip -d'
alias untar='tar xvf'
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract

#------------------------------------------------------------------------------
# ABBREVIATIONS
#------------------------------------------------------------------------------
typeset -A abbreviations
abbreviations=(
    "H"    "| head"
    "G"    "| grep"
    "X"    "| xargs"
    "T"    "| tail"
    "C"    "| cat"
    "W"    "| wc"
    "A"    "| awk"
    "S"    "| sed"
    "E"    "2>&1 > /dev/null"
    "N"    "> /dev/null"

    "g"    "git"
    "gd"   "git diff --color"
    "gf"   "git fetch origin"
    "gst"  "git status --branch --short"
    "gco"  "git checkout"
    "gci"  "git commit -m"
    "gb"   "git branch"
    "ga"   "git add"
    "ga."  "git add ."
    "gps"  "git push origin"
    "gpl"  "git pull origin"
    "gcf"  "git commit --fixup"
    "gr"   "git rebase"
    "gri"  "git rebase -i HEAD~20"
    "ggp"  "git grep --line-number --show-function --color --heading --break"
    "grh"  "git reset --hard"
    "grs"  "git reset --soft"
    "gn"   "git now --all --stat"
)

fzf-gitcommit(){
  tmp=`git log --oneline | fzf-tmux` && echo $tmp | cut -d' ' -f1
}

fzf-gitfiles(){
  git reset HEAD -- >/dev/null 2>&1 \
    & tmp=`git status --porcelain | fzf-tmux -m` && echo $tmp | awk -F ' ' '{print $NF}'
}

magic-abbrev-expand() {
    local MATCH
    LBUFFER=${LBUFFER%%(#m)[.-_a-zA-Z0-9]#}
    LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
    zle self-insert
}

no-magic-abbrev-expand() {
    LBUFFER+=' '

}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

#------------------------------------------------------------------------------
# functions
#------------------------------------------------------------------------------

if (type fzf 2>&1 > /dev/null) ; then
  fshow() {
    local out sha q
    while out=$(
        git log --graph --color=always \
            --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
        fzf --ansi --multi --no-sort --reverse --query="$q" --print-query); do
      q=$(head -1 <<< "$out")
      while read sha; do
        git show --color=always $sha | less -R
      done < <(sed '1d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    done
  }
fi

function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf "$1";;
    *.tar.xz) tar Jxvf "$1";;
    *.zip) unzip "$1";;
    *.lzh) lha e "$1";;
    *.tar.bz2|*.tbz) tar xjvf "$1";;
    *.tar.Z) tar zxvf "$1";;
    *.gz) gzip -d "$1";;
    *.bz2) bzip2 -dc "$1";;
    *.Z) uncompress "$1";;
    *.tar) tar xvf "$1";;
    *.arj) unarj "$1";;
  esac
}

function gituser()
{
  git config --local user.name $1
  git config --local user.email $2
}

#------------------------------------------------------------------------------
# etc
#------------------------------------------------------------------------------
## in vim, enable to map Ctrl-S to file saving
stty -ixon -ixoff

#------------------------------------------------------------------------------
# zplug
#------------------------------------------------------------------------------
## setup
export ZPLUG_HOME=$HOME/.cache/zplug
if [ ! -d $ZPLUG_HOME ]; then
  curl -sL get.zplug.sh | zsh
fi
source $ZPLUG_HOME/init.zsh

## plugins

# zplug "lib/theme-and-appearance", from:oh-my-zsh
# zplug "themes/steeef", from:oh-my-zsh
zplug "themes/duellj", from:oh-my-zsh

zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down

zplug "junegunn/fzf-bin", as:command, from:gh-r, rename-to:"fzf", frozen:1
zplug "junegunn/fzf", as:command, use:'bin/fzf-tmux'
zplug "junegunn/fzf", as:plugin, use:'shell/completion.zsh'

zplug "peco/peco", as:command, from:gh-r

zplug "b4b4r07/enhancd", use:'init.sh'

zplug "b4b4r07/emoji-cli"

zplug "seebi/dircolors-solarized"
if type gls > /dev/null 2>&1; then
  eval `gdircolors $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.ansi-universal`
  alias ls='gls --color=auto'
elif [[ $OSTYPE == *linux* ]]; then
  eval `dircolors $ZPLUG_HOME/repos/seebi/dircolors-solarized/dircolors.ansi-universal`
  alias ls='ls --color=auto'
elif [[ $OSTYPE == *darwin* ]]; then
  export LSCOLORS=gxfxcxdxbxegedabagacad # from itchny
  alias ls='ls -G'
fi
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zplug "github/hub", as:command, from:gh-r

zplug "iwata/git-now", as:command, use:'git-now'
zplug "iwata/git-now", as:command, use:'git-now-add'
zplug "iwata/git-now", as:command, use:'git-now-rebase'
zplug "iwata/git-now", as:command, use:'gitnow-common'
zplug "iwata/git-now", as:command, use:'gitnow-shFlags'

zplug "awslabs/git-secrets", as:command, use:'git-secrets'
[ ! -d $HOME/.git-templates/git-secrets ] && git secrets --install $HOME/.git-templates/git-secrets

zplug 'aws/aws-cli', use:'bin/aws_zsh_completer.sh', nice:10

local os=`[ $OSTYPE = "linux-gnu" ] && echo linux || echo darwin`
zplug direnv/direnv, as:command, from:gh-r, hook-build:"chmod 755 *", use:"*$os*", rename-to:direnv, hook-load:'eval "$(direnv hook zsh)"'

## Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

## Then, source plugins and add commands to $PATH
zplug load --verbose
