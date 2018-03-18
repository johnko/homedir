#!/usr/bin/env bash
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/openssl/bin:$PATH"

[ -e ~/.bash_prompt ] && source ~/.bash_prompt

if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    # Set config variables first
    GIT_PROMPT_ONLY_IN_REPO=0

    GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status
    GIT_PROMPT_IGNORE_SUBMODULES=1 # uncomment to avoid searching for changed files in submodules

    #GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
    GIT_PROMPT_SHOW_UNTRACKED_FILES=no # can be no, normal or all; determines counting of untracked files

    #GIT_PROMPT_SHOW_CHANGED_FILES_COUNT=0 # uncomment to avoid printing the number of changed files

    GIT_PROMPT_START="_LAST_COMMAND_INDICATOR_ ${__USER}${__HOST}${__DIR} ${__DATE}\[${__RESET}\]"    # uncomment for custom prompt start sequence
    GIT_PROMPT_END="${__NEWLINE}${__DEFAULT1}${__SIGN} \[${__RESET}\]"      # uncomment for custom prompt end sequence

    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
fi
