#!/usr/bin/env bash
set -euo pipefail

if ! which go ; then
  echo "!!  Go is required. Install from https://go.dev/dl/"
  exit 1
fi

if ! which docker ; then
  echo "!!  Docker is required. Install from https://docs.docker.com/desktop/"
  exit 1
fi


export GOPATH="$HOME/go"
go get sigs.k8s.io/kind

export PATH="$PATH:$GOPATH/bin"

kind create cluster

kind delete cluster

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
