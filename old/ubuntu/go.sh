#!/bin/sh
set -Ceux

VERSION=`curl "https://golang.org/VERSION?m=text"`
wget "https://dl.google.com/go/$VERSION.linux-amd64.tar.gz"
sudo tar -C /usr/local -xzf $VERSION.linux-amd64.tar.gz
sudo mv /usr/local/go /usr/local/$VERSION
sudo ln -s /usr/local/$VERSION /usr/local/go
rm -rf ./$VERSION.linux-amd64.tar.gz
/usr/local/go/bin/go get golang.org/x/tools/cmd/goimports
/usr/local/go/bin/go get golang.org/x/tools/gopls
