#!/bin/sh
IMAGENAME=dotfilestest

cd `git rev-parse --show-toplevel`

if [ 0 -eq `sudo docker images | grep $IMAGENAME | wc -l` ]; then
cat << EOS | sudo docker build -t $IMAGENAME -
FROM ubuntu:latest
RUN apt-get update -qq && apt-get install -y curl git zsh build-essential && apt-get clean
EOS
fi

sudo docker run -it \
  --name $IMAGENAME \
  --rm \
  -v "$PWD":/app \
  -w /app \
  $IMAGENAME \
  zsh -c "source ./.zshrc ; echo \$?"

