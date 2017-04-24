#!/bin/bash

# Script to download, setup, and install deps for dotfiles
# Ubuntu version
# v0 - totally untested

# before running ensure that there is a valid ssh key authorized for github

cd $HOME

sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-add-repository -y ppa:rael-gc/rvm

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

sudo apt-get update

sudo apt-get install -y \
    rcm \
    git \
    nodejs \
    build-essential \
    rvm \
    neovim \
    google-chrome-stable

sudo npm install -g yarn
sudo yarn global add hotel

git clone git@github.com:jpopesculian/dotfiles.git .dotfiles
git clone git@github.com:robbyrussell/oh-my-zsh.git .oh-my-zsh

cd $HOME
ln -s .dotfiles/rcrc .rcrc
rcup -v

cd $HOME/.config
ln -s $HOME/.vim nvim
