#!/usr/bin/env bash
set -euo pipefail

set -x

LULU_RULES_FILE="$HOME/bin/macos-settings/lulu/rules.json"
if [ -e "$LULU_RULES_FILE" ]; then

  TMPFILE=$(mktemp)
  cp "$LULU_RULES_FILE" "$TMPFILE"
  sed "s,$HOME/,~/,g" <"$TMPFILE" | jq --sort-keys >"$LULU_RULES_FILE"

  set +e
  ERROR=0

  # check if any rules have regex pattern but isEndpointAddrRegex:0
  # shellcheck disable=SC1003
  if grep -A2 -E 'endpointAddr.*\\' "$LULU_RULES_FILE" | grep -B2 -E 'isEndpointAddrRegex.*0'; then
    ERROR=$((ERROR + 1))
  fi

  # check if any rules have regex pattern but isEndpointAddrRegex:0
  if grep -A2 -E 'endpointAddr.*[^"]\*[^"]' "$LULU_RULES_FILE" | grep -B2 -E 'isEndpointAddrRegex.*0'; then
    ERROR=$((ERROR + 1))
  fi

  exit $ERROR
fi
