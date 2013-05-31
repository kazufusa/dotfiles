#!/bin/sh

mkdir -p python_setup
cd python_setup

#install python-dev
sudo aptitude install -y python-dev
# install distribute.
sudo chmod -R 0775 /usr/local
sudo chgrp -R $USER /usr/local
wget http://python-distribute.org/distribute_setup.py
sudo python distribute_setup.py
#install pip
wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py
sudo python get-pip.py
#install virtualenv.
pip install virtualenv
pip install virtualenvwrapper
