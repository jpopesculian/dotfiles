#!/bin/bash

# Script to download, setup, and install deps for dotfiles
# Ubuntu version
# v0 - totally untested

# before running ensure that there is a valid ssh key authorized for github

set -e

pushd $HOME

pushd $HOME/.dotfiles
git submodule update --init --recursive
popd

sudo apt-get update
sudo apt-get install -y curl gnupg

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo apt-add-repository -y ppa:martin-frost/thoughtbot-rcm
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

sudo apt-add-repository -y ppa:neovim-ppa/stable
sudo apt-add-repository -y ppa:yubico/stable

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    build-essential \
    ca-certificates \
    scdaemon \
    curl \
    jq \
    gnome-tweak-tool \
    gnupg-agent \
    htop \
    neovim \
    python-pip \
    python3-pip \
    exuberant-ctags \
    python-fontforge \
    yubioath-desktop \
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
    spotify-client \
    unzip \
    xsel \
    kitty \
    libpam-u2f \
    jq \
    zsh

sudo usermod -aG docker julian

pip2 install configparser
pip3 install --user git+git://github.com/powerline/powerline
pip2 install pynvim
pip3 install pynvim

mkdir -p ~/.oh-my-zsh/custom/themes/
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

mkdir -p ~/.local
git clone https://github.com/b4b4r07/emoji-cli.git ~/.local/emoji-cli


pushd $HOME/Downloads

wget https://github.com/ogham/exa/releases/download/v0.8.0/exa-linux-x86_64-0.8.0.zip
unzip exa-linux-x86_64-0.8.0.zip
sudo mv exa-linux-x86_64 /usr/bin/exa

wget https://github.com/sharkdp/bat/releases/download/v0.11.0/bat_0.11.0_amd64.deb
sudo dpkg -i bat_0.11.0_amd64.deb

wget https://github.com/github/hub/releases/download/v2.12.3/hub-linux-amd64-2.12.3.tgz
tar -xvf hub-linux-amd64-2.12.3.tgz
sudo mv hub-linux-amd64-2.12.3/bin/hub /usr/bin

wget https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
sudo chmod +x diff-so-fancy
sudo mv diff-so-fancy /usr/bin

wget -O prettyping https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
sudo chmod +x prettyping
sudo mv prettyping /usr/bin

popd

# node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
export NVM_DIR="${XDG_CONFIG_HOME/:-$HOME/.}nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# nvm install node
# nvm use node
# npm install -g yarn neovim

# rvm
# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
# curl -sSL https://get.rvm.io | sudo bash -s stable

mkdir -p $HOME/.fonts
mkdir -p $HOME/.config/fontconfig/conf.d
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mv PowerlineSymbols.otf $HOME/.fonts/
mv 10-powerline-symbols.conf $HOME/.config/fontconfig/conf.d/

pushd $HOME/Downloads
git clone git@github.com:ryanoasis/nerd-fonts.git
pushd nerd-fonts
./install.sh
popd
wget https://github.com/tonsky/FiraCode/releases/download/1.206/FiraCode_1.206.zip
mkdir $HOME/.fonts/FiraCode
unzip -d $HOME/.fonts/FiraCode FiraCode_1.206.zip
pushd $HOME/.fonts/FiraCode/otf
$HOME/Downloads/nerd-fonts/font-patcher --mono --careful FiraCode-Bold.otf
$HOME/Downloads/nerd-fonts/font-patcher --mono --careful FiraCode-Regular.otf
$HOME/Downloads/nerd-fonts/font-patcher --mono --careful FiraCode-Medium.otf
$HOME/Downloads/nerd-fonts/font-patcher --mono --careful FiraCode-Light.otf
$HOME/Downloads/nerd-fonts/font-patcher --mono --careful FiraCode-Retina.otf
popd
popd

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
