#!/usr/bin/env bash
set -exo pipefail

# when running in CI and shfmt doesn't exist, install it
if [[ "true" == "$CI" ]]; then
  if ! type shfmt &>/dev/null; then
    SUDO=''
    if type sudo &>/dev/null; then
      SUDO=sudo
    fi
    if type brew &>/dev/null; then
      brew install shfmt
    elif type snap &>/dev/null; then
      INSTALL_COMMAND="snap install shfmt"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    elif type go &>/dev/null; then
      if [[ ! -d "$HOME/bin" ]]; then
        mkdir -p "$HOME/bin"
      fi
      export GOBIN="$HOME/bin"
      export PATH="$GOBIN:$PATH"
      go install mvdan.cc/sh/v3/cmd/shfmt@v3.11.0
      ls -l "$GOBIN/shfmt"
    elif type apt &>/dev/null; then
      SUDO=''
      if type sudo &>/dev/null; then
        SUDO=sudo
      fi
      INSTALL_COMMAND="apt install --yes shfmt"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
fi
set -u

shfmt --version

# Diff with
# shfmt --diff --simplify --indent 2 --case-indent ./
# find . -type f -name '*.envrc' -print0 | xargs -0 --max-procs=2 --verbose -I{} shfmt --diff --simplify --indent 2 --case-indent {}

# Fix with
shfmt --write --simplify --indent 2 --case-indent ./
find . -type f -name '*.envrc' -print0 | xargs -0 --max-procs=2 --verbose -I{} shfmt --write --simplify --indent 2 --case-indent {}

bash -ex ./.github/git-has-uncommited-changes.sh
