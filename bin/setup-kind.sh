#!/usr/bin/env bash
set -euo pipefail

if ! which brew ; then
  echo "!!  Homebrew is required. Install from https://brew.sh/"
  exit 1
fi

if ! which docker ; then
  echo "!!  Docker is required. Install from https://docs.docker.com/desktop/"
  exit 1
fi

brew install \
  kind \
  helm

kind create cluster

kind delete cluster

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
