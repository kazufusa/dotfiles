ZDOTDIR=$HOME/.config/zsh

# bun completions
[ -s "/home/kazufusa/.bun/_bun" ] && source "/home/kazufusa/.bun/_bun"
export DENO_INSTALL=$HOME/.deno
export PATH="$DENO_INSTALL/bin:$PATH"


. "$HOME/.local/bin/env"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
