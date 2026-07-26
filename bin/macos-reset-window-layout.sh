#!/usr/bin/env bash
set -euo pipefail

# continue on failure
set +e

yabai -m config layout float
open -g hammerspoon://autolayout
if [[ -e ~/.yabairc-oneshot ]]; then
  bash ~/.yabairc-oneshot
fi
yabai -m config layout bsp

[ -x "$HOME/.nosleep/diskchart.sh" ] && "$HOME/.nosleep/diskchart.sh"
