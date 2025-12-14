#!/usr/bin/env bash
set -exo pipefail

# when running in CI and shellcheck doesn't exist, install it
if [[ "true" == "$CI" ]]; then
  if ! type shellcheck &>/dev/null; then
    SUDO=''
    if type sudo &>/dev/null; then
      SUDO=sudo
    fi
    if type brew &>/dev/null; then
      brew install shellcheck
    elif type snap &>/dev/null; then
      INSTALL_COMMAND="snap install shellcheck"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    elif type apt &>/dev/null; then
      SUDO=''
      if type sudo &>/dev/null; then
        SUDO=sudo
      fi
      INSTALL_COMMAND="apt install --yes shellcheck"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
fi
set -u

shellcheck --version

set +e

# git submodule status | awk '{print "-a -not -path **/"$2"/**"}' | tr "\n" " " | sed "s,\*\*/,'*,g" | sed "s,/\*\*,*',g" ; echo "\\"

find . -type f \( -name '*.sh' -o -name '*.envrc' \) \
  \
  -a -not -path '*.bash-git-prompt*' -a -not -path '*.zsh/kube-ps1*' -a -not -path '*.zsh/pure*' -a -not -path '*.zsh/zsh-colored-man-pages*' -a -not -path '*.zsh/zsh-command-time*' -a -not -path '*docker-files/squid/ref/docker-squid-cache-all*' -a -not -path '*docker-files/squid/ref/squid-in-a-can*' -a -not -path '*docker-files/squid/ref/squid-npm*' \
  \
  -a -not -name 'macos-homebrew.sh' \
  -print0 | xargs -0 --max-procs=2 --verbose -I{} shellcheck --check-sourced --external-sources {}
