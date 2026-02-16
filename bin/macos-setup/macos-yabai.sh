#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing latest yabai..."

if [[ -e ~/bin/yabai ]]; then
  echo "=>  An older version already installed at ~/bin/yabai"
  exit 1
else
  set -x
  mkdir -p ~/.local/man
  git clone --depth=1 https://github.com/johnko/yabai.git /tmp/yabai.git
  pushd /tmp/yabai.git
  make install
  codesign -fs - bin/yabai
  cp -a bin/yabai ~/bin/yabai
  mkdir -p ~/.local/man
  cp doc/yabai.1 ~/.local/man/
  popd
  rm -fr /tmp/yabai.git
  set +x
fi

echo "=>  Installation complete!"
echo "    To activate, run:"
echo "        yabai --start-service"
