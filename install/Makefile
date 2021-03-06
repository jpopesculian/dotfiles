SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS: -ec

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

DIFF_SO_FANCY_DL_LINK := https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
PRETTYPING_DL_LINK := https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
DOCKER_COMPOSE_DL_LINK := https://github.com/docker/compose/releases/latest/download/docker-compose-$(shell uname -s)-$(shell uname -m)
CTOP_DL_LINK := https://github.com/bcicen/ctop/releases/download/v$(CTOP_VERSION)/ctop-$(CTOP_VERSION)-linux-amd64


all: apt-deps install-assets misc dl-releases node rust fonts zsh file-linking

# MISC

misc: python-alternative pip-deps add-user-groups

pip-deps:
	pip3 install --user git+git://github.com/powerline/powerline
	pip3 install pynvim
.PHONY: pip-deps

add-user-groups:
	sudo usermod -aG docker $(shell whoami)
.PHONY: add-user-groups

python-alternative:
	export PYTHONPATH=$$(readlink -f `which python3`)
	sudo update-alternatives --install /usr/bin/python python $$PYTHONPATH 1
.PHONY: python-alternative

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

npm-deps: $(NVM_DIR)/nvm.sh
	. $(NVM_DIR)/nvm.sh
	nvm use $(NODE_VERSION)
	npm install -g yarn neovim
.PHONY: npm-deps

# RELEASE DOWNLOADS

dl-releases: dl-diff-so-fancy dl-prettyping dl-docker-compose dl-ctop

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

# SGX

sgx-driver: install-sgx-driver sign-sgx-driver

install-sgx-driver:
	curl -s https://download.01.org/intel-sgx/latest/linux-latest/distro/ubuntu20.04-server/driver_readme.txt | awk '{ print $$3 }' |  grep -v "^#\|^$$" | head -n 1 | awk '{print "https://download.01.org/intel-sgx/latest/linux-latest/distro/ubuntu20.04-server/"$$1}' | xargs curl -o /tmp/install-sgx-driver
	sudo chmod +x /tmp/install-sgx-driver
	sudo /tmp/install-sgx-driver
.PHONY: install-sgx-driver

sign-sgx-driver:
	sudo /usr/src/linux-headers-$$(uname -r)/scripts/sign-file sha256 /usr/modules/MOK.priv /usr/modules/MOK.der $$(modinfo -n isgx)
	sudo modprobe isgx
.PHONY: sign-sgx-driver

create-mok-key: /usr/modules/MOK.der
	sudo mokutil --import /usr/modules/MOK.der
.PHONY: create-mok-key

/usr/modules/MOK.der:
	openssl req -new -x509 -newkey rsa:4096 -keyout MOK.priv -outform DER -out MOK.der -nodes -days 36500 -subj "/CN=Driver Signer/"
	sudo mkdir -p /usr/modules
	sudo mv MOK.der /usr/modules
	sudo mv MOK.priv /usr/modules
	sudo chown -R root:root /usr/modules

# APT-DEPS

apt-deps: base-apt-get apt-repos apt-get

base-apt-get:
	sudo apt-get update
	sudo apt-get install -y curl gnupg
.PHONY: base-apt-deps

apt-repos:
	sudo apt-add-repository -y -n ppa:neovim-ppa/stable
	sudo apt-add-repository -y -n ppa:yubico/stable
	sudo apt-add-repository -y -n ppa:ubuntu-mozilla-daily/ppa
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-add-repository -y -n "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(DOCKER_DISTRO) stable"
	curl -s https://repo.protonvpn.com/debian/public_key.asc | sudo apt-key add -
	sudo apt-add-repository -y -n 'deb https://repo.protonvpn.com/debian unstable main'
	curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	curl -s https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
	echo "deb https://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	curl -sS https://downloads.1password.com/linux/keys/1password.asc | sudo apt-key add -
	echo 'deb [arch=amd64] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
	curl -s https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | sudo apt-key add -
	echo 'deb [arch=amd64] https://download.01.org/intel-sgx/sgx_repo/ubuntu focal main' | sudo tee /etc/apt/sources.list.d/intel-sgx.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0
	sudo apt-add-repository -u https://cli.github.com/packages
.PHONY: apt-repo

apt-get:
	sudo apt-get update
	sudo apt-get install -y \
		1password \
		apt-transport-https \
		build-essential \
		brave-browser \
		ca-certificates \
		chrome-gnome-shell \
		containerd.io \
		curl \
		docker-ce \
		docker-ce-cli \
		exuberant-ctags \
		fzf \
		gh \
		gnome-tweak-tool \
		gnupg \
		gnupg-agent \
		htop \
		httpie \
		hub \
		jq \
		kitty \
		libclang-dev \
		libpam-u2f \
		libsgx-headers \
		libssl-dev \
		lld \
		neovim \
		nmap \
		pkg-config \
		python3 \
		python3-fontforge \
		python3-pip \
		protonvpn \
		rcm \
		redis-server \
		scdaemon \
		sgx-aesm-service \
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
