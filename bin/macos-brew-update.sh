#!/usr/bin/env bash
set -euo pipefail

if which brew >/dev/null 2>&1 ; then
  if [ -e Brewfile ]; then
    set -x
    brew bundle
    set +x
    cat Brewfile | grep cask | grep -v '^#' | cut -d' ' -f2 | tr -d '"' | xargs -t -I{} brew install --cask {}
  else
    echo "ERROR: missing 'Brewfile'"
    exit 1
  fi
else
  echo "ERROR: missing 'brew'"
  exit 1
fi
