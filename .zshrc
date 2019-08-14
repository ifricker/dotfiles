# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/ianfricker/.oh-my-zsh

# export SHELL=/bin/zsh
# if [ -t 1 ]; then exec $SHELL; fi

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
COMPLETION_WAITING_DOTS="true"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git alias-tips zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
export EDITOR='vim'
# export ARCHFLAGS="-arch x86_64"
#  ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias be='bundle exec'
alias restart_server='pg_ctl -D /usr/local/var/postgresql@9.6 -l /usr/local/var/postgresql@9.6/server.log start'
alias gs='git status'
alias gl='git log --oneline -10'
alias open_db='psql -d currica_development'
alias open_db_test='psql -d currica_test'
alias web='cd ~/Code/Work/currica/web/'
alias redis_start='redis-server /usr/local/etc/redis.conf'
alias ngrok='./ngrok http 3000'
alias kill_server='kill -9 $(lsof -i tcp:3000 -t)'
alias start_all='foreman start -f Procfile.dev'
alias uninstall_all_gems='gem uninstall -aIx'
alias clean_up_branches='git branch -d $(git branch --merged=master | grep -v master) && git fetch --prune'
alias webpacker_dev_server='./bin/webpack-dev-server'
alias rspec_changed='rspec $(git ls-files --modified --others --exclude="*.swp" --exclude="*.DS_Store" spec)'
alias ssh_pi='sshpass -p raspberry ssh pi@192.168.1.82'

# run spec 50 times, break if fail
function rspec_50() {
    if [ -n "$1" ]
    then
      for i in `seq 50` ; do rspec "$1"; [[ ! $? = 0 ]] && break ; done
    else
      echo Please input spec
    fi
}

# Set token for for gem update script
export GITHUB_TOKEN=NOT_CURRENT_TOKEN
export CIRCLE_TOKEN=NOT_CURRENT_TOKEN

DEFAULT_USER='ianfricker'
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
export PATH="/usr/local/opt/postgresql@9.6/bin:$PATH"
