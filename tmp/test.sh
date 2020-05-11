#!/bin/sh
IMAGENAME=dotfilestest

cd `git rev-parse --show-toplevel`

if [ 0 -eq `docker images | grep $IMAGENAME | wc -l` ]; then
cat << EOS | docker build -t $IMAGENAME -
FROM ubuntu:latest
ENV TZ='Asia/Tokyo'
RUN apt-get update -qq \
  && apt-get install -y tzdata \
  && apt-get install -y \
    automake \
    curl \
    git \
    zsh \
    build-essential \
    libncurses5-dev \
    pkg-config \
    libevent-dev \
    byacc \
    file \
  && apt-get clean
EOS
fi

docker run -it \
  --name $IMAGENAME \
  --rm \
  -v "$PWD":/app \
  -w /app \
  $IMAGENAME \
  zsh -c "make test"
