#!/bin/bash

# Script to download, setup, and install deps for dotfiles
# Ubuntu version
# v0 - totally untested

# before running ensure that there is a valid ssh key authorized for github

pushd $HOME

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo apt-add-repository -y ppa:martin-frost/thoughtbot-rcm
sudo apt-add-repository -y ppa:tista/adapta
sudo add-apt-repository -y ppa:snwh/pulp
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install -y \
    adapta-gtk-theme \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    docker \
    gnome-tweak-tool \
    gnupg-agent \
    google-chrome-stable \
    htop \
    neovim \
    paper-icon-theme \
    python-pip \
    python3-pip \
    rcm \
    redis-server \
    silversearcher-ag \
    software-properties-common \
    tmux \
    tmuxinator \
    unity-tweak-tool \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    zsh

sudo usermod -aG docker julian

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install node
nvm use node
npm install -g yarn

# oh-my-zsh
git clone git@github.com:robbyrussell/oh-my-zsh.git .oh-my-zsh
mkdir -p ~/.oh-my-zsh/custom/themes/
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

# rvm
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
curl -sSL https://get.rvm.io | sudo bash -s stable

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

popd
