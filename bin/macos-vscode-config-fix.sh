#!/usr/bin/env bash
set -euo pipefail

set -x

if [ -e "$HOME/Library/Application Support/Code/User/settings.json" ]; then

  sed -i '' "s,$HOME/,~/,g" "$HOME/Library/Application Support/Code/User/settings.json"
  TMPFILE=$(mktemp)
  cp "$HOME/Library/Application Support/Code/User/settings.json" "$TMPFILE"
  jq --sort-keys <"$TMPFILE" >"$HOME/Library/Application Support/Code/User/settings.json"

fi

if [ -e "$HOME/Library/Application Support/Cursor/User/settings.json" ]; then

  sed -i '' "s,$HOME/,~/,g" "$HOME/Library/Application Support/Cursor/User/settings.json"
  TMPFILE=$(mktemp)
  cp "$HOME/Library/Application Support/Cursor/User/settings.json" "$TMPFILE"
  jq --sort-keys <"$TMPFILE" >"$HOME/Library/Application Support/Cursor/User/settings.json"

fi
