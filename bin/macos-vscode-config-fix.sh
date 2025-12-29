#!/usr/bin/env bash
set -euo pipefail

set -x

if [ -e "$HOME/Library/Application Support/Code/User/settings.json" ]; then

  sed -i '' "s,$HOME/,~/,g" "$HOME/Library/Application Support/Code/User/settings.json"

fi
