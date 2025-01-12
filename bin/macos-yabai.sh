#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing latest yabai..."

if [ -e ~/bin/yabai ]; then
  echo "=>  An older version already installed at ~/bin/yabai"
  exit 1
else
  mkdir -p ~/.local/man
  curl -L https://raw.githubusercontent.com/koekeishiya/yabai/master/scripts/install.sh | sh /dev/stdin ~/bin ~/.local/man
fi

echo "=>  Installation complete!"
echo "    To activate, run:"
echo "        yabai --start-service"
echo "=>  Setup is complete!"
