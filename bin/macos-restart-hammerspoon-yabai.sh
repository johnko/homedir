#!/usr/bin/env bash
set -euo pipefail

set +u
YABAI_WINDOW_ID="$1"
if [[ -z "$YABAI_WINDOW_ID" ]]; then
  # only stop yabai if called without window id
  yabai --stop-service || true
fi

open -g hammerspoon://autolayout

if [[ -z "$YABAI_WINDOW_ID" ]]; then
  # only start yabai if called without window id because it was stopped
  yabai --start-service
else
  # called from yabai signal so restart it
  yabai --restart-service
fi
