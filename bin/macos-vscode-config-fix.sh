#!/usr/bin/env bash
set -euo pipefail

set -x

VSCODE_CONFIG_FILE="$HOME/Library/Application Support/Code/User/settings.json"
if [ -e "$VSCODE_CONFIG_FILE" ]; then

  TMPFILE=$(mktemp)
  cp "$VSCODE_CONFIG_FILE" "$TMPFILE"
  sed "s,$HOME/,~/,g" <"$TMPFILE" | jq --sort-keys >"$VSCODE_CONFIG_FILE"

fi

CURSOR_CONFIG_FILE="$HOME/Library/Application Support/Cursor/User/settings.json"
if [ -e "$CURSOR_CONFIG_FILE" ]; then

  TMPFILE=$(mktemp)
  cp "$CURSOR_CONFIG_FILE" "$TMPFILE"
  sed "s,$HOME/,~/,g" <"$TMPFILE" | jq --sort-keys >"$CURSOR_CONFIG_FILE"

fi
