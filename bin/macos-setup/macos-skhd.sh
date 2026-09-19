#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing latest skhd..."

if [[ -e ~/bin/skhd ]]; then
  echo "=>  An older version already installed at ~/bin/skhd"
  exit 1
else
  set -x
  git clone -b mouse2 https://github.com/johnko/skhd.git /tmp/skhd.git
  pushd /tmp/skhd.git
  git log -n 1 | grep 377762bde2e1ea732dcb9097e7c933cae3db60ac || exit 1
  # sudo xcode-select -switch /Library/Developer/CommandLineTools
  export CPATH="$(xcrun --show-sdk-path)/usr/include"
  export SDKROOT=$(xcrun --show-sdk-path)
  make install
  codesign -fs - bin/skhd
  cp -a bin/skhd ~/bin/skhd
  popd
  rm -fr /tmp/skhd.git
  set +x
fi

echo "=>  Installation complete!"
echo "    To activate, run:"
echo "        skhd --start-service"
