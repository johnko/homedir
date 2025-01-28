##########
umask 0077

##########
# enable Ctrl+A, Ctrl+E, Ctrl+R, etc, shortcuts again in zsh sub shells https://unix.stackexchange.com/a/574740
bindkey -e

##########
[ ! -e ~/.ssh ] && install -d -m 700 ~/.ssh
if [ -e ~/.ssh/config ]; then
  grep -q "HashKnownHosts" ~/.ssh/config || printf -- "HashKnownHosts no\n" >> ~/.ssh/config
else
  printf -- "HashKnownHosts no\n" >> ~/.ssh/config
fi
[ -e ~/.ssh ] && chmod 700 ~/.ssh
[ -e ~/.ssh/config ] && chmod 600 ~/.ssh/config
[ -e ~/.ssh/id_rsa ] && chmod 600 ~/.ssh/id_rsa
[ -e ~/.ssh/id_rsa.pub ] && chmod 600 ~/.ssh/id_rsa.pub
[ -e ~/.ssh/id_ed25519 ] && chmod 600 ~/.ssh/id_ed25519
[ -e ~/.ssh/id_ed25519.pub ] && chmod 600 ~/.ssh/id_ed25519.pub
[ -e ~/.ssh/known_hosts ] && chmod 600 ~/.ssh/known_hosts

##########
for i in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
  [ ! -d $i ] && mkdir -p $i
done

##########
# color for zsh auto complete suggestion output https://stackoverflow.com/questions/23152157/how-does-the-zsh-list-colors-syntax-work
zstyle ':completion:*:commands' ignored-patterns '.DS_Store|.gitignore|macos-settings|macos-setup|vm|yabai_cycle_clockwise.sh'
zstyle ':completion:*:commands' list-colors '=*=31'
zstyle ':completion:*:options' list-colors '=^(-- *)=36'
zstyle ':completion:*:parameters'  list-colors '=*=36'
zstyle ':completion:*:builtins' list-colors '=*=35'
zstyle ':completion:*:aliases' list-colors '=*=35'

##########
# use zsh pure theme
PURE_PROMPT_SYMBOL=$'🚀\n⚑'
export VIRTUAL_ENV_DISABLE_PROMPT=12
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
prompt pure

##########
# Plugins from https://github.com/unixorn/awesome-zsh-plugins#plugins
ZSH_COMMAND_TIME_MSG="took %s"
ZSH_COMMAND_TIME_COLOR="cyan"
source $HOME/.zsh/zsh-command-time/command-time.plugin.zsh
source $HOME/.zsh/kube-ps1/kube-ps1.sh
PROMPT='$(kube_ps1)'$PROMPT
source $HOME/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh

##########
# More env/aliases
for i in ~/.bash_path ~/.bash_exports ~/.bash_aliases ~/.bash_colors ~/.bash_secrets ~/.devops-tools; do
  [ -f $i ] && source $i
done

PROMPT='[$(arch)]'$PROMPT

export NVM_DIR="$HOME/.nvm"
[ -e $NVM_DIR ] || mkdir -p $NVM_DIR
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export GPG_TTY=$(tty)

##########
# Time on right
RPROMPT='%D{%F %T}'
TMOUT=1
TRAPALRM() {
  zle reset-prompt
}

##########
# zsh completion
if type brew &>/dev/null ; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
# kubectl completion
autoload -U +X compinit && compinit
if type kubectl &>/dev/null ; then
  source <(kubectl completion zsh)
fi
if type fx &>/dev/null ; then
  source <(fx --comp zsh)
fi
