##########
umask 0077
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
# use zsh pure theme
export VIRTUAL_ENV_DISABLE_PROMPT=12
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
prompt pure
##########
# Plugins from https://github.com/unixorn/awesome-zsh-plugins#plugins
##########
ZSH_COMMAND_TIME_MSG="took %s"
ZSH_COMMAND_TIME_COLOR="cyan"
source $HOME/.zsh/zsh-command-time/command-time.plugin.zsh
##########
source $HOME/.zsh/kube-ps1/kube-ps1.sh
PROMPT='$(kube_ps1)'$PROMPT
##########
source $HOME/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh
##########
[ -f ~/.bash_aliases ] && source ~/.bash_aliases
[ -f ~/.bash_exports ] && source ~/.bash_exports
[ -f ~/.bash_path ] && source ~/.bash_path
##########
export NVM_DIR="$HOME/.nvm"
[ -e $NVM_DIR ] || mkdir -p $NVM_DIR
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
