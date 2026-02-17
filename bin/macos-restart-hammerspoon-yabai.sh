#!/usr/bin/env bash
set -euo pipefail

yabai --stop-service ; open -g hammerspoon://autolayout ; yabai --start-service
