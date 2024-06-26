# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export PATH="$PATH:$HOME/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin:$HOME/.dnx/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.vimpkg/bin:$HOME/.local/bin:$HOME/.local/bin"

export PYTHON_USER_SITE=$(python3 -m site --user-site)

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

ZSH_DOTENV_PROMPT=false

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(tmuxinator tmux history zsh-autosuggestions vi-mode dotenv fzf-zsh-plugin)
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# User configuration


# export MANPATH="/usr/local/man:$MANPATH"

export GO_VERSION="1.16"
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export GOROOT="/usr/local/go-$GO_VERSION"
export GO111MODULE=on
export PATH="$GOROOT/bin:$GOBIN:$PATH"

export ANDROID_HOME="/opt/android-studio"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/bin"
export ANDROID_USER_HOME="$HOME/.android-sdk"
export ANDROID_NDK_HOME="$ANDROID_USER_HOME/ndk"

export RUST_HOME="$HOME/.cargo/bin"
export PATH="$PATH:$RUST_HOME"

export PATH="$PATH:$HOME/.android-sdk/flutter/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"

export PATH="$HOME/.nimble/bin:$PATH"
alias nimrun="nim c -r --verbosity:0"

export EDITOR=nvim

export NODE_ENV='development'

export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"

export PATH="$PATH:/opt/wabt"

source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
alias gpgkill="gpg-connect-agent learn /bye"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# autosuggestions
bindkey '^@' autosuggest-execute
bindkey '^[[Z' autosuggest-accept

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias lah='ls -lah'

alias et=$EDITOR
NOTES_PATH="$HOME/Dropbox"

cn() {
    if [ $# -eq 0 ]; then
        echo "$NOTES_PATH/$(cat $NOTES_PATH/.current)"
    else
        echo $@ > "$NOTES_PATH/.current" && cn
    fi
}

n() {
    if [ $# -eq 0 ]; then
        vf "$(cn)"
    else
        et "$(cn)/$(date +%Y%m%d%H%M) $@.md"
    fi
}

alias mux=tmuxinator

# _direnv_hook() {
#   eval "$(direnv export zsh)";
# }
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
fi

if [[ -n $VIRTUAL_ENV && -e "${VIRTUAL_ENV}/bin/activate" ]]; then
# source "${VIRTUAL_ENV}/bin/activate"  # commented out by conda initialize
fi

FZF_TMUX=1
alias fzf=fzf-tmux
alias fzg='ag --nobreak --nonumbers --noheading . | fzf'
alias fzh='ag --hidden --ignore .git -l -g "" . | fzf'

alias please='sudo $(fc -ln -1)'
alias cl='clear'
alias cll='clear && $(fc -ln -1 -1)'
alias cds='cd $(pwd -P)'
alias http-server='http-server --logger --verbose'

rustd() {
    rustup docs --path | xargs dirname | xargs http-server -p 1337 &
    if [ -z "$1" ]; then; search=""; else; search="?search=$1"; fi
    xdg-open "http://localhost:1337/std/index.html$search"
    fg
}
crated() {
    crate_name="$(tomlq -f Cargo.toml package.name)"
    if [ -z "$crate_name" ]; then; crate_name="$(tomlq -f Cargo.toml workspace.members | jq -r '.[0]')"; fi
    http-server -p 1338 target/doc &
    if [ -z "$1" ]; then; search=""; else; search="?search=$1"; fi
    xdg-open "http://localhost:1338/$(echo $crate_name | tr - _)/index.html$search"
    fg
}

export DOCKER_BUILDKIT=1
export COMPOSE_DOCKER_CLI_BUILD=1

# export PATH="/usr/local/eosio/bin:$PATH"

nvm-sudo() { sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/node" "/usr/local/bin/node"; sudo ln -s "$NVM_DIR/versions/node/$(nvm version)/bin/npm" "/usr/local/bin/npm" }

alias internet-connected='wget --spider --quiet http://google.com'
alias http='noglob http'
alias scw='noglob scw'

# todo
# TODO_DIR=/opt/todo.txt_cli-2.11.0
# alias t=$TODO_DIR/todo.sh
# source $TODO_DIR/todo_completion complete -F _todo t

# kubectl
source <(kubectl completion zsh)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

kgetall() { kubectl api-resources --verbs=list --namespaced -o name | xargs -n1 kubectl get --show-kind --ignore-not-found "$@" }

# lua
# alias lua=lua5.3
# alias luac=luac5.3

# emsdk (emscripten)
EMSDK_HOME="/home/julian/Development/riddleandcode/emsdk"
EMSCRIPTEN="$EMSDK_HOME/upstream/emscripten"
alias emsdk-env="source $EMSDK_HOME/emsdk_env.sh"

# swig
export SWIG_PATH="$HOME/opt/swigtool/bin"
export PATH=$SWIG_PATH:$PATH

# LD LIBRARY
export LD_LIBRARY_PATH=/usr/local/lib:/usr/lib
export PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig

# sgx
if [[ -d /opt/intel/sgxsdk ]]; then
    export SGX_HOME=/opt/intel/sgxsdk
    source $SGX_HOME/environment
    export SGXSDK_INCLUDE_DIRS=$SGX_HOME/include
fi
export SGX_DEVICE=/dev/$(ls /dev | grep -m 1 sgx)

# pyenv
# export PYENV_ROOT="$HOME/opt/pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# if command -v pyenv 1>/dev/null 2>&1;then
#     eval "$(pyenv init -)"
# fi

# emoji cli
if [[ -d $HOME/.local/emoji-cli ]]; then
    source $HOME/.local/emoji-cli/emoji-cli.zsh
fi
export EMOJI_CLI_USE_EMOJI=1

# Primus
export PRIMUS_HOME=/usr/local/primus
export PATH=$PRIMUS_HOME/bin:$PRIMUS_HOME/openssl/1.0.2m/bin:$PRIMUS_HOME/apache/2.4.29/bin:$PATH
export LD_LIBRARY_PATH=$PRIMUS_HOME/lib:$LD_LIBRARY_PATH
export C_INCLUDE_PATH=$PRIMUS_HOME/include:$C_INCLUDE_PATH

# alias loadenv() { f=${1:-".env"}; export $(grep -v '^#' $f | xargs -d '\n'); }
# alias unloadenv() { f=${1:-".env"}; unset $(grep -v '^#' $f | sed -E 's/(.*)=.*/\1/' | xargs -d '\n'); }

# BETTER CLI
alias cat="bat"
alias ls="lsd --group-dirs first --classify"
alias ping="prettyping --nolegend"
alias fzfp="fzf --preview 'bat --color \"always\" {}'"
fzfl() { ls ${1:-.} | fzf --preview "bat --color \"always\" ${1:-.}/{}" | awk "{print \"${1:-.}/\" \$0}" }
alias wttr="curl v2.wttr.in"
alias m="make"
alias mls="make -qp | awk -F':' '/^[a-zA-Z0-9][^\$#\/\t=]*:([^=]|$)/ {split(\$1,A,/ /);for(i in A)print A[i]}' | sort -u"
alias dk="docker"
alias dkc="docker compose"
copy() { \cat $1 | pbcopy }
alias dfimage="docker run -v /var/run/docker.sock:/var/run/docker.sock --rm laniksj/dfimage"
alias lnmap="nmap -sP $( hostname -I | awk '/(192|10)\./{print $1}' | sed -E 's/([0-9]*\.[0-9]*\.[0-9]*)(\.[0-9]*)/\1.1\/24/')"
alias rusti="evcxr"
mkcd() { mkdir -p $1 && cd $1 }
alias gsync="rsync -vhra --include='**.gitignore' --exclude='/.git' --filter=':- .gitignore' --delete-after"
bdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}

alias v="nvim"
vf() { fn=$(fzfl $1); if [ ! -z $fn ]; then; nvim $fn; fi  }
bindkey -s '^e' "vf\n"

eval "$POST_RC_EXEC"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# codi
codi() {
  local syntax="${1:-javascript}"
  shift
  nvim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

# export SOLANG_DIR="/opt/solang"
# if [ -d $SOLANG_DIR ]; then
#     PATH="$SOLANG_DIR/llvm13.0/bin:$PATH"
# fi

export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"

export RNC_TRUSTED_NODE_PATH_TO_SETTINGS="$HOME/.config/rnc/trusted-node"

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"


# Scaleway CLI autocomplete initialization.
# eval "$(scw autocomplete script shell=zsh)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export DPRINT_INSTALL="/home/julian/.dprint"
export PATH="$DPRINT_INSTALL/bin:$PATH"

export PATH=/home/julian/.groundcover/bin:${PATH}
. "$HOME/.cargo/env"

# pnpm
export PNPM_HOME="/home/julian/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
