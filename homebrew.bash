#!/bin/bash
set -eux

if [ "$SHELL_PLATFORM" != 'osx' ]; then
  exit 0
fi

if type brew >/dev/null 2>&1; then
  exit
fi

# install brew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

if type brew >/dev/null 2>&1; then
  brew doctor
else
  log_fail "error: brew: failed to install"
  exit 1
fi
