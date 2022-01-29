##########
umask 0077
##########
# use zsh pure theme
fpath+=/Users/jon/.zsh/pure
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

