# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir virtualenv vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

ZSH_TMUX_AUTOSTART=true
export DISABLE_AUTO_TITLE=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git tmuxinator tmux history zsh-autosuggestions vi-mode emoji)
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# User configuration


export PATH="$PATH:$HOME/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin:$HOME/.dnx/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.vimpkg/bin:$HOME/.local/bin:$HOME/.local/bin"
# export MANPATH="/usr/local/man:$MANPATH"

export GO_VERSION="1.12"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export GOROOT="/usr/local/go-$GO_VERSION"
export GO111MODULE=on
export PATH="$GOROOT/bin:$GOBIN:$PATH"

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

export RUST_HOME="$HOME/.cargo/bin"
export PATH="$PATH:$RUST_HOME"

# source /usr/local/rvm/scripts/rvm

export PATH="$PATH:/opt/flutter/bin"

export PATH=/home/julian/.nimble/bin:$PATH
alias nimrun="nim c -r --verbosity:0"

export EDITOR=nvim

export NODE_ENV='development'

export JAVA_HOME='/usr/lib/jvm/default-java'

export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

export PATH="$PATH:/opt/wabt"

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# powerline
# powerline-daemon -q
# powerline_installation="$HOME/.local/lib/python3.5/site-packages/powerline"
# . "$powerline_installation/bindings/zsh/powerline.zsh"

# autosuggestions
bindkey '^@' autosuggest-execute
bindkey '^[[Z' autosuggest-accept

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias lah='exa -lagh -a --git --group-directories-first'

alias et=$EDITOR
NOTES_PATH="$HOME/Dropbox/notes"
alias notes="mkdir -p $NOTES_PATH/$(date +%Y/%m/%d) && $EDITOR $NOTES_PATH/$(date +%Y/%m/%d)/notes.md"

alias mux=tmuxinator

# _direnv_hook() {
#   eval "$(direnv export zsh)";
# }
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
fi

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
  source "${VIRTUAL_ENV}/bin/activate"
fi

eval "$(hub alias -s)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
FZF_TMUX=1
alias fzf=fzf-tmux
alias fzg='ag --nobreak --nonumbers --noheading . | fzf'
alias fzh='ag --hidden --ignore .git -l -g "" . | fzf'

alias please='sudo $(fc -ln -1)'
alias cl='clear'
alias cll='clear && $(fc -ln -1 -1)'
alias codereview='git pull-request -pl "code review"'
alias glorp='ruby -ane '
alias cds='cd $(pwd -P)'
alias goreflex='reflex -r "\.go$" make'

alias vpn-on='sudo protonvpn-cli -update && sudo protonvpn-cli -cc'
alias vpn-off='sudo protonvpn-cli -disconnect'

alias inds="gnome-shell-extension-tool -r appindicatorsupport@rgcjonas.gmail.com"

# eos
# export EOS_HOME="/home/julian/Development/eos-dev"
# export EOS_ACCOUNT="julian"

# export EOS_DOCKER_COMPOSE="$EOS_HOME/docker-compose.yml"
# alias eosio-exec='docker-compose -f $EOS_DOCKER_COMPOSE exec'
# alias eosio-up='docker-compose -f $EOS_DOCKER_COMPOSE up -d'
# alias cleos='docker-compose -f $EOS_DOCKER_COMPOSE exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'
# alias eosio-set-keys='source $EOS_HOME/set_keys'
# alias eosio-unlock='eosio-set-keys && cleos wallet open && cleos wallet unlock --password $private_key'
# alias eosio-init='eosio-up && eosio-unlock'
# eosio-compile() { d=/contracts/usr; docker exec eos-dev_nodeosd_1 eosiocpp -o $d/$1.wast $d/$1.cpp; }
# eosio-abi() { d=/contracts/usr; docker exec eos-dev_nodeosd_1 eosiocpp -g $d/$1.abi $d/$1.cpp; }
# eosio-build() { eosio-compile $1 && eosio-abi $1 }
# eosio-load() { d=/contracts/usr/$(dirname $1); f=$(basename $1); cleos set contract ${2:-$EOS_ACCOUNT} $d $f.wasm $f.abi; }
# eosio-install() { eosio-build $1 && eosio-load $1 $2 }

# EOS_MAIN_COMPOSE="/home/julian/Development/eos-main/docker-compose.yml"
# alias eosio-main-up='docker-compose -f $EOS_MAIN_COMPOSE up -d'
# alias cleos-main='docker-compose -f $EOS_MAIN_COMPOSE exec keosd-main /opt/eosio/bin/cleos -u https://api.eosnewyork.io:443 --wallet-url http://localhost:8900'

# export PATH="/usr/local/eosio/bin:$PATH"

nvm-sudo() { sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node"; sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm" }

alias internet-connected='wget --spider --quiet http://google.com'

# eval $(thefuck --alias)

# gdrive
GDRIVE_DIR=/mnt/gcsf
alias gdrive-mnt="sudo systemctl start gdrive"
alias gdrive="ranger $GDRIVE_DIR"

# todo
# TODO_DIR=/opt/todo.txt_cli-2.11.0
# alias t=$TODO_DIR/todo.sh
# source $TODO_DIR/todo_completion complete -F _todo t

# kubectl
# source <(kubectl completion zsh)

# lua
# alias lua=lua5.3
# alias luac=luac5.3

# emsdk (emscripten)
emsdk-env() { source /opt/emsdk/emsdk_env.sh }

# swig
export SWIG_PATH=/home/julian/opt/swigtool/bin
export PATH=$SWIG_PATH:$PATH

# LD LIBRARY
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig

# sgx
if [[ -d /opt/intel ]]; then
    export SGX_HOME=/opt/intel/sgxsdk
    source $SGX_HOME/environment
    export SGXSDK_INCLUDE_DIRS=$SGX_HOME/include
fi

# pyenv
export PYENV_ROOT="$HOME/opt/pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1;then
    eval "$(pyenv init -)"
fi

# Primus
export PRIMUS_HOME=/usr/local/primus
export PATH=$PRIMUS_HOME/bin:$PRIMUS_HOME/openssl/1.0.2m/bin:$PRIMUS_HOME/apache/2.4.29/bin:$PATH
export LD_LIBRARY_PATH=$PRIMUS_HOME/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$PRIMUS_HOME/include:$C_INCLUDE_PATH

# alias loadenv() { f=${1:-".env"}; export $(grep -v '^#' $f | xargs -d '\n'); }
# alias unloadenv() { f=${1:-".env"}; unset $(grep -v '^#' $f | sed -E 's/(.*)=.*/\1/' | xargs -d '\n'); }

# BETTER CLI
alias cat="bat"
alias ls="exa"
alias ping="prettyping --nolegend"
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias help="tldr"
alias m="make"
copy() { \cat $1 | pbcopy }
emopy() { echo -n "$emoji[$1]" | pbcopy && echo "$emoji[$1]" }
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm laniksj/dfimage"

eval "$POST_RC_EXEC"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# opam configuration
# test -r /home/julian/.opam/opam-init/init.zsh && . /home/julian/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/julian/.sdkman"
[[ -s "/home/julian/.sdkman/bin/sdkman-init.sh" ]] && source "/home/julian/.sdkman/bin/sdkman-init.sh"
