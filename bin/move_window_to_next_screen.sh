#!/usr/bin/env bash
set -euo pipefail

json=$(yabai -m query --windows --window)
is_floating=$(echo "$json" | jq '.["is-floating"]')

if [[ $is_floating == "false" ]]; then
  if ! yabai -m window --display next --focus &>/dev/null ; then
    yabai -m window --display first --focus &>/dev/null
  fi
else
  # Hammerspoon window:moveToScreen(screen:next
  open -g hammerspoon://movetonextscreen
fi
