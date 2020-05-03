SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS: -ec

HUB_VERSION := 2.14.2
CTOP_VERSION=0.7.3
NVM_VERSION := 0.35.3
FIRACODE_VERSION := 3.1
NODE_VERSION := lts/erbium
DOCKER_DISTRO := eoan

INSTALL_LOC := $(HOME)/.dotfiles
ASSETS_LOC := $(INSTALL_LOC)/install/assets
ZSH_CUSTOM_LOC := $(HOME)/.oh-my-zsh/custom
LOCAL_LOC := $(HOME)/.local
DOWNLOADS_LOC := $(HOME)/Downloads
NVM_DIR := $(HOME)/.nvm
CARGO_HOME := $(HOME)/.cargo
FONTS_LOC := $(HOME)/.fonts
FONTCONFIG_LOC := $(HOME)/.config/fontconfig/conf.d
NERDFONTS_LOC := $(DOWNLOADS_LOC)/nerd-fonts

HUB_DL_LINK := https://github.com/github/hub/releases/download/v$(HUB_VERSION)/hub-linux-amd64-$(HUB_VERSION).tgz
DIFF_SO_FANCY_DL_LINK := https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
PRETTYPING_DL_LINK := https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
DOCKER_COMPOSE_DL_LINK := https://github.com/docker/compose/releases/latest/download/docker-compose-$(shell uname -s)-$(shell uname -m)
CTOP_DL_LINK := https://github.com/bcicen/ctop/releases/download/v$(CTOP_VERSION)/ctop-$(CTOP_VERSION)-linux-amd64


all: apt-deps install-assets misc dl-releases node rust fonts zsh file-linking

# MISC

misc: pip-deps add-user-groups

pip-deps:
	pip2 install configparser
	pip3 install --user git+git://github.com/powerline/powerline
	pip2 install pynvim
	pip3 install pynvim
.PHONY: pip-deps

add-user-groups:
	sudo usermod -aG docker $(shell whoami)
.PHONY: add-user-groups

# ZSH

zsh: zsh-custom change-shell

zsh-custom:
	mkdir -p $(ZSH_CUSTOM_LOC)/themes/
	mkdir -p $(ZSH_CUSTOM_LOC)/plugins/
	mkdir -p $(LOCAL_LOC)
	git clone https://github.com/bhilburn/powerlevel9k.git $(ZSH_CUSTOM_LOC)/themes/powerlevel9k
	git clone https://github.com/zsh-users/zsh-autosuggestions $(ZSH_CUSTOM_LOC)/plugins/zsh-autosuggestions
	git clone https://github.com/b4b4r07/emoji-cli.git $(LOCAL_LOC)/emoji-cli
.PHONY: zsh-custom

change-shell:
	chsh -s $(shell which zsh)
.PHONY: zsh-shell

# FILE LINKING

file-linking: rcup nvim-link $(HOME)/Development git-to-ssh

rcup:
	pushd $(HOME)
	ln -s $(INSTALL_LOC)/rcrc .rcrc
	rcup -v
	popd
.PHONY: rcup

nvim-link:
	pushd $(HOME)/.config
	ln -s ../.vim nvim
	popd
.PHONY: nvim-link

$(HOME)/Development:
	mkdir -p $(HOME)/Development

git-to-ssh:
	pushd $(INSTALL_LOC)
	git remote rm origin
	git remote add origin git@github.com:jpopesculian/dotfiles.git
	popd
.PHONY: git-to-ssh

# FONTS

fonts: powerline-fonts nerd-fonts fc-cache

powerline-fonts:
	pushd $(DOWNLOADS_LOC)
	mkdir -p $(FONTS_LOC)
	mkdir -p $(FONTCONFIG_LOC)
	wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
	wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
	mv PowerlineSymbols.otf $(FONTS_LOC)
	mv 10-powerline-symbols.conf $(FONTCONFIG_LOC)
	popd
.PHONY: powerline-fonts

$(NERDFONTS_LOC)/install.sh:
	pushd $(DOWNLOADS_LOC)
	git clone https://github.com/ryanoasis/nerd-fonts.git
	pushd $(NERDFONTS_LOC)
	./install.sh
	popd
	popd

nerd-fonts: $(NERDFONTS_LOC)/install.sh
	pushd $(NERDFONTS_LOC)
	wget https://github.com/tonsky/FiraCode/releases/download/$(FIRACODE_VERSION)/FiraCode_$(FIRACODE_VERSION).zip
	mkdir $(FONTS_LOC)/FiraCode
	unzip -d $(FONTS_LOC)/FiraCode FiraCode_$(FIRACODE_VERSION).zip
	pushd $(FONTS_LOC)/FiraCode/otf
	$(NERDFONTS_LOC)/font-patcher --mono --careful FiraCode-Bold.otf
	$(NERDFONTS_LOC)/font-patcher --mono --careful FiraCode-Regular.otf
	$(NERDFONTS_LOC)/font-patcher --mono --careful FiraCode-Medium.otf
	$(NERDFONTS_LOC)/font-patcher --mono --careful FiraCode-Light.otf
	$(NERDFONTS_LOC)/font-patcher --mono --careful FiraCode-Retina.otf
	popd
	popd
.PHONY: nerd-fonts

fc-cache:
	fc-cache -vf $(FONTS_LOC)
.PHONY: fc-cache

# RUST

rust: rustup-components cargo-deps

$(CARGO_HOME)/env:
	curl https://sh.rustup.rs -o rustup-init
	sudo chmod +x rustup-init
	./rustup-init -y --default-toolchain nightly

rustup-components: $(CARGO_HOME)/env
	source $(CARGO_HOME)/env
	rustup component add rls rust-analysis rust-src clippy rustfmt
.PHONY: rustup-components

cargo-deps: $(CARGO_HOME)/env
	source $(CARGO_HOME)/env
	cargo install cargo-edit cargo-watch lsd bat
.PHONY: cargo-deps

# NODE

node: nvm npm-deps

$(NVM_DIR)/nvm.sh:
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v$(NVM_VERSION)/install.sh | bash

nvm: $(NVM_DIR)/nvm.sh
	. $(NVM_DIR)/nvm.sh
	nvm install $(NODE_VERSION)
	nvm use $(NODE_VERSION)
	nvm alias default $(NODE_VERSION)
.PHONY: nvm

npm-deps:
	npm install -g yarn neovim
.PHONY: npm-deps

# RELEASE DOWNLOADS

dl-releases: dl-hub dl-diff-so-fancy dl-prettyping dl-docker-compose dl-ctop

dl-hub:
	pushd $(DOWNLOADS_LOC)
	wget $(HUB_DL_LINK)
	tar -xvf hub-linux-amd64-$(HUB_VERSION).tgz
	sudo mv hub-linux-amd64-$(HUB_VERSION)/bin/hub /usr/bin
	popd
.PHONY: dl-hub

dl-diff-so-fancy:
	pushd $(DOWNLOADS_LOC)
	wget $(DIFF_SO_FANCY_DL_LINK)
	sudo chmod +x diff-so-fancy
	sudo mv diff-so-fancy /usr/bin
	popd
.PHONY: dl-diff-so-fancy

dl-prettyping:
	pushd $(DOWNLOADS_LOC)
	wget -O prettyping $(PRETTYPING_DL_LINK)
	sudo chmod +x prettyping
	sudo mv prettyping /usr/bin
	popd
.PHONY: dl-prettyping

dl-docker-compose:
	sudo curl -L $(DOCKER_COMPOSE_DL_LINK) -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
.PHONY: dl-docker-compose

dl-ctop:
	sudo wget $(CTOP_DL_LINK) -O /usr/local/bin/ctop
	sudo chmod +x /usr/local/bin/ctop
.PHONY: dl-ctop

# ASSETS

install-assets: add-tmux-terminfo import-yubikey-pubkey

add-tmux-terminfo:
	tic -x $(ASSETS_LOC)/tmux.terminfo
.PHONY: add-tmux-terminfo

import-yubikey-pubkey:
	gpg --import $(ASSETS_LOC)/pubkey.asc
.PHONY: import-yubikey-pubkey

# APT-DEPS

apt-deps: base-apt-get apt-repos apt-get

base-apt-get:
	sudo apt-get update
	sudo apt-get install -y curl gnupg
.PHONY: base-apt-deps

apt-repos:
	sudo apt-add-repository -y -n ppa:martin-frost/thoughtbot-rcm
	sudo apt-add-repository -y -n ppa:neovim-ppa/stable
	sudo apt-add-repository -y -n ppa:yubico/stable
	sudo apt-add-repository -y -n ppa:ubuntu-mozilla-daily/ppa
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-add-repository -y -n "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(DOCKER_DISTRO) stable"
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
.PHONY: apt-repo

apt-get:
	sudo apt-get update
	sudo apt-get install -y \
		apt-transport-https \
		build-essential \
		ca-certificates \
		chrome-gnome-shell \
		containerd.io \
		curl \
		docker-ce \
		docker-ce-cli \
		exuberant-ctags \
		firefox-trunk \
		gnome-tweak-tool \
		gnupg \
		gnupg-agent \
		htop \
		httpie \
		jq \
		kitty \
		libpam-u2f \
		libssl-dev \
		neovim \
		nmap \
		pkg-config \
		python-fontforge \
		python-pip \
		python3-pip \
		rcm \
		redis-server \
		scdaemon \
		silversearcher-ag \
		software-properties-common \
		spotify-client \
		tmux \
		tmuxinator \
		unity-tweak-tool \
		unzip \
		xsel \
		yubioath-desktop \
		zsh
.PHONY: apt-deps
