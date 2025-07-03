#!/usr/bin/env bash
set -euo pipefail

if type brew &>/dev/null ; then
  if [[ -e Brewfile ]] ; then
    EXTRA_BREWFILE=""
    if [[ -e .Brewfile ]] ; then
      EXTRA_BREWFILE=".Brewfile"
    fi
    for i in $(
      brew list | \
      grep -v -E "1password|applesimutils|docker|terraform|"$(
        cat Brewfile $EXTRA_BREWFILE | grep -v 'instance_eval' | grep -v '^#' | grep -v '^$' | tr -d , | tr -d '"' | awk '{print $2}' | tr "\n" '|' | sed 's,|$,,'
      )
    ); do
      brew uninstall $i &>/dev/null && (echo ; echo "brew uninstall $i") || echo -n "."
    done
    echo
    brew bundle
  else
    echo "ERROR: missing 'Brewfile'"
    exit 1
  fi
else
  echo "ERROR: missing 'brew'"
  exit 1
fi
