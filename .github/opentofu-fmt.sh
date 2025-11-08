#!/usr/bin/env bash
set -exo pipefail

# when running in CI and opentofu doesn't exist, install it
if [[ "true" == "$CI" ]]; then
  if ! type tofu &>/dev/null; then
    SUDO=''
    if type sudo &>/dev/null; then
      SUDO=sudo
    fi
    if type brew &>/dev/null; then
      brew install opentofu
    elif type snap &>/dev/null; then
      INSTALL_COMMAND="snap install --classic opentofu"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
fi
set -u

export IAC_BIN=tofu

$IAC_BIN version

$IAC_BIN fmt -list=true -check -recursive ./

# Fix with
# tofu fmt -recursive ./
