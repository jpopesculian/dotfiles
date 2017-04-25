#!/bin/bash

# Script to download, setup, and install deps for dotfiles
# Ubuntu version
# v0 - totally untested

# before running ensure that there is a valid ssh key authorized for github

cd $HOME

sudo apt-add-repository -y ppa:martin-frost/thoughtbot-rcm
sudo apt-add-repository -y ppa:tista/adapta
sudo add-apt-repository -y ppa:snwh/pulp
sudo add-apt-repository -y ppa:ricotz/docky
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -

sudo apt-get update

sudo apt-get install -y \
    rcm \
    git \
    nodejs \
    build-essential \
    neovim \
    zsh \
    tmux \
    python-pip \
    python3-pip \
    unity-tweak-tool \
    gnome-tweak-tool \
    adapta-gtk-theme \
    paper-icon-theme \
    plank \
    redshift redshift-gtk \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    docker \
    tmuxinator \
    redis-server \
    ruby \
    golang-go \
    htop \
    network-manager-openvpn-gnome \
    silversearcher-ag \
    google-chrome-stable

sudo npm install -g yarn
sudo yarn global add hotel
sudo yarn global add browser-sync
sudo yarn global add prettier
sudo yarn global add eslint

# oh-my-zsh
git clone git@github.com:robbyrussell/oh-my-zsh.git .oh-my-zsh

# rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | sudo bash -s stable

# powerline
pip2 install --user git+git://github.com/powerline/powerline
pip3 install --user git+git://github.com/powerline/powerline

mkdir -p $HOME/.fonts
mkdir -p $HOME/.config/fontconfig/conf.d
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf $HOME/.fonts/
mv 10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/
fc-cache -vf $HOME/.fonts/

# dotfiles syncing
cd $HOME
ln -s .dotfiles/rcrc .rcrc
rcup -v

# neovim
cd $HOME/.config
ln -s $HOME/.vim nvim

# Development folder
mkdir -p $HOME/Development

# zsh shell
chsh -s $(which zsh)
