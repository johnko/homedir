#!/usr/bin/env bash
set -euo pipefail

json=$(yabai -m query --windows --window)
is_floating=$(echo "$json" | jq '.["is-floating"]')

if [[ $is_floating == "false" ]]; then
  yabai -m window --toggle float
fi

# Hammerspoon window:moveTo(x,0)
open -g hammerspoon://movetotopofscreen
