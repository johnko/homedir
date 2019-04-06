# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/usr/local/bin:${PATH}"
export PATH="/usr/local/opt/curl/bin:${PATH}"
export PATH="/usr/local/opt/openssl/bin:${PATH}"
# export PATH="${HOME}/bin:${PATH}"

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

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
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-completions
  osx
  ruby
  bundler
  rake
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# User configuration
# Customization for POWERLEVEL9K
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time root_indicator background_jobs ram battery time)
#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv rbenv kubecontext context dir dir_writable vcs)
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(virtualenv rbenv context dir dir_writable vcs)
POWERLEVEL9K_TIME_FORMAT='%D{%Y-%m-%d %H:%M:%S %Z%z}'

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
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# Set BEAKER_debug to true if you need to debug (default unset)
# export BEAKER_debug=true
# Set BEAKER_destroy to no if you need to debug (we default to yes)
export BEAKER_destroy=yes

export GOPATH="${HOME}/go"

DEFAULT_USER="$(whoami)"
prompt_context(){}

# For gcloud
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'
#gcloud info
#gcloud auth login
#gcloud config set project foobar
#gcloud services list
#gcloud services disable sql-component.googleapis.com
#gcloud services disable cloudapis.googleapis.com bigquery-json.googleapis.com datastore.googleapis.com sql-component.googleapis.com storage-api.googleapis.com storage-component.googleapis.com

#gcloud services list
# NAME                               TITLE
# bigquery-json.googleapis.com       BigQuery API
# compute.googleapis.com             Compute Engine API
# container.googleapis.com           Kubernetes Engine API
# containerregistry.googleapis.com   Container Registry API
# deploymentmanager.googleapis.com   Cloud Deployment Manager V2 API
# iam.googleapis.com                 Identity and Access Management (IAM) API
# iamcredentials.googleapis.com      IAM Service Account Credentials API
# logging.googleapis.com             Stackdriver Logging API
# monitoring.googleapis.com          Stackdriver Monitoring API
# oslogin.googleapis.com             Cloud OS Login API
# pubsub.googleapis.com              Cloud Pub/Sub API
# replicapool.googleapis.com         Compute Engine Instance Group Manager API
# replicapoolupdater.googleapis.com  Compute Engine Instance Group Updater API
# resourceviews.googleapis.com       Compute Engine Instance Groups API
# storage-api.googleapis.com         Google Cloud Storage JSON API

# For rbenv (ruby env)
eval "$(rbenv init -)"
#export PATH="${HOME}/.rbenv/shims:${PATH}"

# Install ruby 2.4
#rbenv install -l
#rbenv install 2.4.5
#rbenv version
#rbenv local 2.4.5
#gem env home
#curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | bash

# This should stay at THE END
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
