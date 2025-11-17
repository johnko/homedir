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
else
  CI=false
fi
set -u

export IAC_BIN=tofu

$IAC_BIN version

for WORKSPACE in $(find . \( -name '*.tf' -o -name '*.otf' \) -not -path '*/.terraform/*' -not -path '*/docs/*/example/*' -print0 | xargs -0 -I{} dirname {} | sort -u); do
  bash -e .github/tf.sh "$WORKSPACE" validate
  if [[ "true" == "$CI" ]]; then
    # Git will refuse to modify untracked nested git repositories (directories with a .git subdirectory) unless a second -f is given.
    git clean -ffxd .
  fi
done
