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

find . -type f \( -name '*.sh' -o -name '*.envrc' \) -print0 | xargs -0 -P2 -I{} shellcheck --check-sourced --external-sources {}
