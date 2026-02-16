#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing latest borders..."

if [[ -e ~/bin/borders ]]; then
  echo "=>  An older version already installed at ~/bin/borders"
  exit 1
else
  set -x
  git clone https://github.com/johnko/JankyBorders.git /tmp/JankyBorders.git
  pushd /tmp/JankyBorders.git
  make all
  codesign -fs - bin/borders
  cp -a bin/borders ~/bin/borders
  popd
  rm -fr /tmp/borders.git
  set +x
fi

echo "=>  Installation complete!"
