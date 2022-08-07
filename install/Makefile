SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS: -ec

CTOP_VERSION=0.7.7
BTOP_VERSION=1.2.8
NVM_VERSION := 0.35.3
FIRACODE_VERSION := 3.1
NODE_VERSION := lts/erbium

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

DIFF_SO_FANCY_DL_LINK := https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
PRETTYPING_DL_LINK := https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
DOCKER_COMPOSE_DL_LINK := https://github.com/docker/compose/releases/latest/download/docker-compose-$(shell uname -s)-$(shell uname -m)
CTOP_DL_LINK := https://github.com/bcicen/ctop/releases/download/v$(CTOP_VERSION)/ctop-$(CTOP_VERSION)-linux-amd64
BTOP_DL_LINK := https://github.com/aristocratos/btop/releases/download/v$(BTOP_VERSION)/btop-x86_64-linux-musl.tbz


all: apt-deps install-assets misc dl-releases node rust fonts zsh file-linking flatpak

# MISC

misc: pip-deps add-user-groups

pip-deps:
	python3 -m pip install --user git+https://github.com/powerline/powerline
	python3 -m pip install pynvim
.PHONY: pip-deps

add-user-groups:
	sudo usermod -aG docker $(shell whoami)
	newgrp docker
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
	pushd $(DOWNLOADS_LOC)
	curl https://sh.rustup.rs -o rustup-init
	sudo chmod +x rustup-init
	./rustup-init -y --default-toolchain nightly
	popd

rustup-components: $(CARGO_HOME)/env
	source $(CARGO_HOME)/env
	rustup component add rust-analysis rust-src clippy rustfmt
.PHONY: rustup-components

cargo-deps: $(CARGO_HOME)/env
	source $(CARGO_HOME)/env
	cargo install cargo-edit cargo-watch cargo-expand cargo-tree lsd bat difftastic
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

npm-deps: $(NVM_DIR)/nvm.sh
	. $(NVM_DIR)/nvm.sh
	nvm use $(NODE_VERSION)
	npm install -g yarn neovim
.PHONY: npm-deps

# RELEASE DOWNLOADS

dl-releases: dl-diff-so-fancy dl-prettyping dl-docker-compose dl-ctop dl-btop

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

dl-btop:
	mkdir -p "$(DOWNLOADS_LOC)/btop"
	pushd "$(DOWNLOADS_LOC)/btop"
	wget -O btop.tbz $(BTOP_DL_LINK)
	tar -xvf btop.tbz
	sudo make install
	popd
	rm -rf "$(DOWNLOADS_LOC)/btop"
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
	sudo mkdir -p /etc/apt/keyrings
	# apt-add-repos
	sudo apt-add-repository -y -n ppa:neovim-ppa/stable
	sudo apt-add-repository -y -n ppa:yubico/stable
	sudo apt-add-repository -y -n ppa:ubuntu-mozilla-daily/ppa
	sudo add-apt-repository ppa:serge-rider/dbeaver-ce
	# docker
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	echo "deb [arch=$$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list
	# spotify
	curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	# rcm
	sudo wget -q https://apt.thoughtbot.com/thoughtbot.gpg.key -O /etc/apt/trusted.gpg.d/thoughtbot.gpg
	echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
	# 1password
	curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/keyrings/1password-archive-keyring.gpg
	echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password-archive-keyring.gpg] https://downloads.1password.com/linux/debian/amd64 stable main' | sudo tee /etc/apt/sources.list.d/1password.list
	sudo mkdir -p /etc/debsig/policies/AC2D62742012EA22/
	curl -sS https://downloads.1password.com/linux/debian/debsig/1password.pol | sudo tee /etc/debsig/policies/AC2D62742012EA22/1password.pol
	sudo mkdir -p /usr/share/debsig/keyrings/AC2D62742012EA22
	curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo gpg --dearmor --output /usr/share/debsig/keyrings/AC2D62742012EA22/debsig.gpg
	# github-cli
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
	sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
	echo "deb [arch=amd64 signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
.PHONY: apt-repo

apt-get:
	sudo apt-get update
	sudo apt-get install -y \
		1password \
		apt-transport-https \
		build-essential \
		ca-certificates \
		containerd.io \
		curl \
		dbeaver-ce \
		docker-ce \
		docker-ce-cli \
		flatpak \
		fzf \
		gh \
		gnome-tweaks \
		gnupg \
		gnupg-agent \
		httpie \
		jq \
		kitty \
		libssl-dev \
		neovim \
		nmap \
		pkg-config \
		python3 \
		python3-fontforge \
		python3-pip \
		rcm \
		scdaemon \
		silversearcher-ag \
		software-properties-common \
		spotify-client \
		tmux \
		tmuxinator \
		unzip \
		xsel \
		yubioath-desktop \
		zsh
.PHONY: apt-deps

# FLATPACK

flatpak: flatpak-repo flatpak-install

flatpak-repo:
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
.PHONY: flatpak-repo

flatpak-install:
	flatpak install -y flathub md.obsidian.Obsidian
.PHONY: flatpak-install
