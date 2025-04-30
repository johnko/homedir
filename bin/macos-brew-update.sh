#!/usr/bin/env bash
set -euo pipefail

if type brew &>/dev/null ; then
  if [[ -e Brewfile ]] ; then
    set -x
    brew bundle || true
    for i in $(cat Brewfile | grep cask | grep -v '^#' | cut -d' ' -f2 | tr -d '"') ; do
      set -x
      brew install --cask $i || brew install --force --cask $i || true
      set +x
    done
    brew cleanup
  else
    echo "ERROR: missing 'Brewfile'"
    exit 1
  fi
else
  echo "ERROR: missing 'brew'"
  exit 1
fi
