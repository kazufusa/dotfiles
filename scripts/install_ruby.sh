#!/bin/sh

sudo aptitude -y update
sudo aptitude -y upgrade
sudo 
sudo aptitude -y install gcc-c++ patch readline readline-devel
sudo aptitude -y install zlib zlib-devel libffi-devel
sudo aptitude -y install openssl-devel make bzip2 autoconf automake libtool bison
sudo aptitude -y install gdbm-devel tcl-devel tk-devel
sudo aptitude -y install libxslt-devel libxml2-devel
sudo aptitude -y install libyaml-devel

curl -L https://get.rvm.io | bash -s stable --ruby=1.9.3 # or --rails
