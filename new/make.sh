#!/bin/sh

set -Ceux

apt-get update
apt-get upgrade
apt-get install -y curl wget make build-essential git

make
