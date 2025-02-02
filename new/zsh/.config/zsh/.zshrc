# homebrew

if [[ "$(uname)" == 'Darwin' ]]; then
 HOMEBREW_HOME='/opt/homebrew'
else
 HOMEBREW_HOME='/home/linuxbrew/.linuxbrew'
fi

eval "$($HOMEBREW_HOME/bin/brew shellenv)"


