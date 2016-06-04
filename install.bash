#!/bin/bash
set -eux

export DOTPATH=$DOTPATH
echo $DOTPATH


# PLATFORM
export SHELL_PLATFORM='unknown'
ostype() { echo "$OSTYPE" | tr '[:upper:]' '[:lower:]'; }
case "$(ostype)" in
    *'linux'*)  SHELL_PLATFORM='linux' ;;
    *'darwin'*) SHELL_PLATFORM='osx'   ;;
    *'bsd'*)    SHELL_PLATFORM='bsd'   ;;
esac

bash ./homebrew.bash
bash ./homebrew_installs.bash
sh ./linux.sh
