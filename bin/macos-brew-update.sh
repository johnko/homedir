#!/usr/bin/env bash
set -euo pipefail

if type brew &>/dev/null; then
  cd ~/
  if [[ -e Brewfile ]]; then
    EXTRA_BREWFILE=""
    if [[ -e .Brewfile ]]; then
      EXTRA_BREWFILE=".Brewfile"
    fi
    set -x
    brew bundle || true
    set -x
    # using ls because we might not have permission as user to use test -e /usr/local/bin/kubectl
    # shellcheck disable=SC2010
    if ls -1 /usr/local/bin | grep kubectl; then
      sudo chown "$(whoami)" /usr/local/bin/kubectl || true
      sudo chown -h "$(whoami)" /usr/local/bin/kubectl || true
    fi
    set +x
    for i in $(cat Brewfile $EXTRA_BREWFILE | grep cask | grep -v '^#' | cut -d' ' -f2 | tr -d '"'); do
      set -x
      brew install --cask "$i" || brew install --force --cask "$i" || true
      set +x
    done
    set -x
    brew upgrade
    brew cleanup --prune=all
  else
    echo "ERROR: missing 'Brewfile'"
    exit 1
  fi
else
  echo "ERROR: missing 'brew'"
  exit 1
fi
