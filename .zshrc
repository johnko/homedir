#

# use zsh pure theme
fpath+=/Users/jon/.zsh/pure
autoload -U promptinit; promptinit
zstyle :prompt:pure:prompt:success color green
prompt pure


ZSH_COMMAND_TIME_MSG="took %s"
ZSH_COMMAND_TIME_COLOR="cyan"
source $HOME/.zsh/zsh-command-time/command-time.plugin.zsh

source $HOME/.zsh/zsh-colored-man-pages/colored-man-pages.plugin.zsh

