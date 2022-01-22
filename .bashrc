# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

# set umask in case .profile didn't
umask 0077

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
fi

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

for i in ~/.vim/backups ~/.vim/swaps ~/.vim/undo; do
    [ ! -d $i ] && mkdir -p $i
done

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Custom exports
[ -f ~/.bash_exports ] && source ~/.bash_exports

# Custom PS1 PS2 prompt
[ -f ~/.bash_prompt ] && source ~/.bash_prompt

# Custom PATH
[ -f ~/.bash_path ] && source ~/.bash_path

# Custom completion
[ -f ~/.bash_completion ] && source ~/.bash_completion

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        source /etc/bash_completion
    fi
    [ -f /usr/local/etc/bash_completion ] && source /usr/local/etc/bash_completion
fi
