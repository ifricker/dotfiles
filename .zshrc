# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/ianfricker/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(alias-tips git)

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# [[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

# [[ -s ~/.zshrc ]] && source ~/.zshrc

export PATH="$HOME/.npm-packages/bin:$PATH"

export PATH="/usr/local/opt/postgresql@9.5/bin:$PATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

alias gl='git log --pretty=oneline -10'
alias generate_password="openssl rand -base64 40 | sed -e 's/[\+=\/]//g'"

# Database tools
alias db_drop='docker exec -i db dropdb firstdelivery -U firstdelivery -h localhost'
alias db_download='curl http://192.168.1.171/light.dump -o /tmp/light.dump'
alias db_create='docker exec -i db createdb firstdelivery -U firstdelivery -h localhost'
alias db_load='docker exec -i db pg_restore -v -d firstdelivery -U firstdelivery -Fc -h localhost < /tmp/light.dump'
alias refresh_db='db_drop && db_download && db_create && db_load'

alias docker_start_pt='docker compose up -d webhook-db webhook-redis light-pt-db pt-redis'
alias dcpt='docker compose up -d light-pt-db pt-redis'
alias parrot_docker='docker compose up -d parrot-db'
alias bym='bundle && yarn && rails db:migrate && rails db:create RAILS_ENV=test && spring stop'
alias docker_start_albatross='docker compose up -d webhook-db webhook-redis light-pt-db flight-db pt-redis albatross'
alias pt='cd ~/Code/PackageTracker'
alias wp="cd ~/Code/PackageTracker && ./bin/webpacker-dev-server"
alias gcd='git checkout main'

alias dc='docker compose'
alias be='bundle exec'
alias skiq="bundle exec sidekiq"
alias kill_server='kill -9 $(lsof -i tcp:3001 -t)'
alias build_api_docs='SWAGGER_DRY_RUN=0 RAILS_ENV=test rails rswag'
alias apitest='airspace rails_console -e apitest -a pt'

alias docker_cleanup='docker system prune -af --volumes'

alias start_ngrok='ngrok http 80'
alias echo_server='http-echo-server 80'

# review app scripts
# usage:
#   set_review_pr
#   gcp_edit_config
#   gcp_restart_app && gcp_pod_status

function set_review_pr() {
  export APP_NUM=$1
}

function gcp_edit_config() {
  kubectl -n pt-pr-$APP_NUM edit cm pt-config
}

function gcp_restart_app() {
  kubectl -n pt-pr-$APP_NUM rollout restart deployment
}


function gcp_pod_status() {
  kubectl -n pt-pr-$APP_NUM rollout status deployment
}

# edit_apittest_env
# restart_apitest && apitest_status
function edit_apitest_env() {
  kubectl edit cm pt-apitest-config -n apitest-apps
}
function restart_apitest() {
  kubectl rollout restart deployment/pt -n apitest-apps
}
function apitest_status() {
  kubectl rollout status deployment/pt -n apitest-apps
}

alias vim="nvim"
alias oldvim="\vim"

# Load Git completion
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"

export CIRCLE_CI_TOKEN=fbcd7d868d7a4c3ff0d8fb05f6d6f2aba3b2b379
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export GPG_TTY=$(tty)

export GOPRIVATE=github.com/airspacetechnologies/*

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ianfricker/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ianfricker/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ianfricker/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ianfricker/google-cloud-sdk/completion.zsh.inc'; fi

export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export GEMHOME="/Users/ianfricker/.gem/ruby/2.6.0"
export CYPRESS_PT_PASSWORD='rpjNnFnP<L%^z(xC'
# shopt -s extglob # Required to enable the `+(...)` extended pattern
