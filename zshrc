# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

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
plugins=(git tmuxinator tmux history zsh-autosuggestions)
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# User configuration

GO_VERSION="1.9"

export PATH="$PATH:$HOME/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin:$HOME/.dnx/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:$HOME/.rvm/bin:$HOME/.rvm/bin:$HOME/.go/bin:$HOME/.vimpkg/bin:$HOME/.local/bin:/usr/lib/go-$GO_VERSION/bin"
# export MANPATH="/usr/local/man:$MANPATH"

export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
export GOROOT="/usr/lib/go-$GO_VERSION"

export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_EMULATOR_USE_SYSTEM_LIBS=1
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

export RUST_HOME="$HOME/.cargo/bin"
export PATH="$PATH:$RUST_HOME"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export EDITOR=nvim
export NVIM_TUI_ENABLE_CURSOR_SHAPE=1

export NODE_ENV='development'

export JAVA_HOME='/usr/lib/jvm/default-java'

source $ZSH/oh-my-zsh.sh

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
powerline-daemon -q
powerline_installation="$HOME/.local/lib/python3.5/site-packages/powerline"
. "$powerline_installation/bindings/zsh/powerline.zsh"

# autosuggestions
bindkey '^@' autosuggest-execute
bindkey '^[[Z' autosuggest-accept

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias lah='ls --color -lah --group-directories-first'

alias et=$EDITOR
NOTES_PATH="$HOME/Documents/notes"
alias notes="mkdir -p $NOTES_PATH/$(date +%Y/%m/%d) && $EDITOR $NOTES_PATH/$(date +%Y/%m/%d)/notes.md"
alias todo=todolist

alias mux=tmuxinator

_direnv_hook() {
  eval "$(direnv export zsh)";
}
typeset -ag precmd_functions;
if [[ -z ${precmd_functions[(r)_direnv_hook]} ]]; then
  precmd_functions+=_direnv_hook;
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

alias vpn-on='sudo protonvpn-cli -connect'
alias vpn-off='sudo protonvpn-cli -disconnect'

export EOS_DOCKER_COMPOSE="/home/julian/Development/eos/Docker/docker-compose-latest.yml"
alias eosio-up='docker-compose -f $EOS_DOCKER_COMPOSE up -d'
alias cleos='docker-compose -f $EOS_DOCKER_COMPOSE exec keosd /opt/eosio/bin/cleos -u http://nodeosd:8888 --wallet-url http://localhost:8900'
alias eosiocpp='docker-compose -f $EOS_DOCKER_COMPOSE exec keosd /opt/eosio/bin/eosiocpp'

alias internet-connected='wget --spider --quiet http://google.com'

eval $(thefuck --alias)

eval "$POST_RC_EXEC"
