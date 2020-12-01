#!/usr/bin/env bash
set -euo pipefail

# Debian / Ubuntu
if command -v apt-get >/dev/null 2>&1 ; then
  echo "=>  Detected apt-get..."
  export DEBIAN_FRONTEND=noninteractive
  # Dependency for some npm packages
  sudo apt-get install --yes build-essential
  # Add deb repository
  curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
  sudo apt-get install --yes nodejs
fi

echo "=>  Detecting npm..."
# Last one wins
command -v npm >/dev/null 2>&1 && NPM_BIN="npm"

echo "=>  Installing latest npm..."
if [ -n "${NPM_BIN}" ] ; then
  ${NPM_BIN} config set registry https://registry.npmjs.org/ 2>&1 | awk '{print "    "$0}'
  ${NPM_BIN} config list 2>&1 | awk '{print "    "$0}'
  ${NPM_BIN} install --global npm 2>&1 | awk '{print "    "$0}'
fi
if ! command -v npm >/dev/null 2>&1 ; then
  echo "!!  Failed to install npm"
  exit 1
fi

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
