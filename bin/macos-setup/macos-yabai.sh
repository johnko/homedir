#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing latest yabai..."

if [[ -e ~/bin/yabai ]] ; then
  echo "=>  An older version already installed at ~/bin/yabai"
  exit 1
else
  mkdir -p ~/.local/man
  git clone --depth=1 https://github.com/johnko/yabai.git /tmp/yabai.git
  pushd /tmp/yabai.git
    cat scripts/install.sh | sh /dev/stdin ~/bin ~/.local/man
  popd
  rm -fr /tmp/yabai.git
fi

echo "=>  Installation complete!"
echo "    To activate, run:"
echo "        yabai --start-service"
echo "=>  Setup is complete!"
