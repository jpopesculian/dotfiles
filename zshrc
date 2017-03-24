# Path to your oh-my-zsh installation.
export ZSH=/home/julian/.oh-my-zsh

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
plugins=(git tmuxinator bundler tmux history bundler)

# User configuration

export PATH="/home/julian/.dnx/runtimes/dnx-mono.1.0.0-beta5/bin:/home/julian/.dnx/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/julian/.rvm/bin:/home/julian/.rvm/bin:/home/julian/.go/bin:/home/julian/.vimpkg/bin"
# export MANPATH="/usr/local/man:$MANPATH"

export GOPATH="/home/julian/.go"
export GOBIN="$GOPATH/bin"
export GOROOT="/usr/lib/go-1.7"

export ANDROID_HOME="/home/julian/Android/Sdk"
export PATH="$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools"

export RUST_HOME="/home/julian/.cargo/bin"
export PATH="$PATH:$RUST_HOME"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

export EDITOR=nvim

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
powerline_installation='/usr/local/lib/python3.5/dist-packages/powerline'
. "$powerline_installation/bindings/zsh/powerline.zsh"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
alias lah='ls --color -lah --group-directories-first'

alias et=$EDITOR
NOTES_PATH="$HOME/Documents/notes"
alias notes="mkdir -p $NOTES_PATH/$(date +%Y/%m/%d) && $EDITOR $NOTES_PATH/$(date +%Y/%m/%d)/notes.md"

alias mux=tmuxinator

if hash direnv 2>/dev/null; then
    eval "$(direnv hook zsh)"
fi

# git sync
git() { if [[ $@ == 'sync' ]]; then command git-umatm; else command git "$@"; fi }

dong() { 
    notification="notify-send 'Ding [$@]: Timer is up!'"
    ding $@ -c $notification --no-timer&
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
alias fzf=fzf-tmux
alias fzg='ag --nobreak --nonumbers --noheading . | fzf'
alias fzh='ag --hidden --ignore .git -l -g "" . | fzf'

# github#knqyf263/pet
function pet-last() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^s' pet-select

eval "$POST_RC_EXEC"
