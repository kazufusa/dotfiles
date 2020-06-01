#------------------------------------------------------------------------------
# general
#------------------------------------------------------------------------------
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

## completions
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

#------------------------------------------------------------------------------
# PATH
#------------------------------------------------------------------------------
if type brew > /dev/null 2>&1; then
  PATH=/usr/local/bin:$PATH
fi

mkdir -p $HOME/bin
if [ -d $HOME/Dropbox/forpath ]; then
  PATH=$HOME/bin:$HOME/Dropbox/forpath:$PATH
else
  PATH=$HOME/bin:$PATH
fi

#------------------------------------------------------------------------------
# variables
#------------------------------------------------------------------------------
# zsh config for hist file
if [ -d $HOME/Dropbox/dotfiles ]; then
  ZSH_CONFIG_PATH=$HOME/Dropbox/dotfiles
else
  ZSH_CONFIG_PATH=$HOME/.zsh
fi

if ! [ -d $ZSH_CONFIG_PATH ]; then
  mkdir -p $ZSH_CONFIG_PATH
fi

export TERM=screen-256color

# Go
export _GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$_GOROOT/bin:$PATH
export GO111MODULE=on

#------------------------------------------------------------------------------
# history
#------------------------------------------------------------------------------
HISTFILE=$ZSH_CONFIG_PATH/.histfile
HISTSIZE=50000
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
if [ -x "$(command -v gls)" ]; then
  alias ls='gls --color=auto'
else
  alias ls='ls --color=auto'
fi
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

#------------------------------------------------------------------------------
# Abbreviations
#------------------------------------------------------------------------------
setopt extended_glob
typeset -A abbreviations
abbreviations=(
    "g"    "git"
    "gd"   "git diff --color"
    "gdc"  "git diff --color --cached"
    "gda"  "git diff --color -w --ignore-all-space --ignore-blank-lines"
    "gf"   "git fetch origin"
    "gst"  "git status --branch --short"
    "gco"  "git checkout"
    "gci"  "git commit -m"
    "gcf"  "git commit --fixup"
    "gca"  "git commit -m 'initial commit' --allow-empty"
    "gb"   "git branch"
    "ga"   "git add"
    "ga."  "git add ."
    "gps"  "git push origin"
    "gpl"  "git pull origin"
    "gr"   "git rebase"
    "gri"  "git rebase -i HEAD~5"
    "ggp"  "git grep --line-number --show-function --color --heading --break"
    "grh"  "git reset --hard"
    "grs"  "git reset --soft"
    "gn"   "git now --all --stat"
    "gcz"  "git cz"
    "dk"   "docker"
    "dkcm" "docker-compose"
    "rmansi" "sed 's/\x1b\[[0-9;]*m//g'"
    "jne"  "jupyter nbconvert --ExecutePreprocessor.timeout=-1 --to notebook --execute"
    "iconv" "iconv -f cp932 -t utf8"
)
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
# etc
#------------------------------------------------------------------------------
# in vim, enable to map Ctrl-S to file saving
stty -ixon -ixoff

#------------------------------------------------------------------------------
# zinit
#------------------------------------------------------------------------------
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing DHARMA Initiative Plugin Manager (zdharma/zinit)…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f" || \
        print -P "%F{160}▓▒░ The clone has failed.%f"
fi
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit installer's chunk

zinit light "zsh-users/zsh-syntax-highlighting"
zinit light "zsh-users/zsh-autosuggestions"
zinit ice lucid atload"zicompinit; zicdreplay"; zinit light "zsh-users/zsh-completions"
zinit light "zsh-users/zsh-history-substring-search"
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-down

# docker and docker-compose
zinit ice as"completion"
zinit snippet https://raw.githubusercontent.com/docker/compose/master/contrib/completion/zsh/_docker-compose
# zinit ice as"completion"
# zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker
zinit light "zsh-users/zsh-docker"

# anyenv
zinit ice lucid wait"!0" as"program" pick"bin/anyenv" \
        atload"eval \"\$(anyenv init -)\"; \
        [[ -d ${HOME}/.config/anyenv/anyenv-install ]] || anyenv install --force-init" \
        atclone"git clone https://github.com/znz/anyenv-update.git $HOME/.anyenv/plugins/anyenv-update"
zinit light anyenv/anyenv

# fzf
zinit ice lucid wait"!0" from"gh-r" as"program"
zinit load junegunn/fzf-bin
zinit ice lucid wait"!0" as"command" pick"bin/fzf-tmux"
zinit load junegunn/fzf
zinit ice lucid wait"!0" multisrc"shell/{completion,key-bindings}.zsh"
zinit load junegunn/fzf

# hub
zinit ice lucid wait"!0" from"gh-r" as"program" mv"hub-*/bin/hub -> hub"
zinit load github/hub

# git-now
zinit ice lucid wait"!0" as"program" pick"{git-now,git-now-add,git-now-rebase,gitnow-common,gitnow-shFlags}"
zinit light "iwata/git-now"

# enhancd; TODO useful but command
zinit ice lucid wait"!0"; zinit light "b4b4r07/enhancd"
export ENHANCD_DOT_ARG=a
export ENHANCD_HYPHEN_ARG=a

zinit ice lucid wait"0c" lucid reset \
    atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
            \${P}sed -i '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
            \${P}dircolors -b LS_COLORS > c.zsh" \
    atpull"%atclone" pick"c.zsh" nocompile"!" \
    atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}'
zinit light trapd00r/LS_COLORS

zinit ice wait"!0"; zinit light "b4b4r07/emoji-cli"

zinit ice lucid wait"!0" from"gh-r" as"program" mv"jq-* -> jq"
zinit load stedolan/jq

zinit ice lucid wait"!0a" as"null"\
  atclone" \
    mkdir -p $HOME/.tmux/plugins; \
    ln -s $HOME/.zinit/plugins/tmux-plugins---tpm $HOME/.tmux/plugins/tpm; \
    setup_my_tmux_plugin tpm;"
zinit light tmux-plugins/tpm

zinit ice as"program" atpull"%atclone" make \
  atclone"ln -fs $HOME/.zinit/plugins/tmux---tmux/tmux $HOME/bin/tmux;./autogen.sh; ./configure"
zinit light tmux/tmux

zinit ice as"program" atpull"%atclone" make pick"src/tig" \
  atclone"make configure; ./configure --enable-widec --with-ncursesw"
zinit light jonas/tig

zinit ice lucid from"gh-r" as"program" atload"eval \"\$(starship init zsh)\""
zinit light starship/starship
