#!/usr/bin/env bash
set -euo pipefail

# continue on failure
set +e

yabai -m config layout float
open -g hammerspoon://autolayout
yabai -m config layout bsp
