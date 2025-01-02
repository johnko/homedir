#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing latest skhd..."

if [ -e ~/bin/skhd ]; then
  echo "=>  An older version already installed at ~/bin/skhd"
  exit 1
else
  git clone https://github.com/johnko/skhd /tmp/skhd.git
  pushd /tmp/skhd.git
    make install
    cp -a bin/skhd ~/bin/skhd
  popd
  rm -fr /tmp/skhd.git
fi

echo "=>  Installation complete!"
echo "    To activate, run:"
echo "        skhd --start-service"
echo "=>  Setup is complete!"