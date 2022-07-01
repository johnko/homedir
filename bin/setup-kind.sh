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
export PATH="$PATH:$GOPATH/bin"

go get sigs.k8s.io/kind

go get helm.sh/helm/v3
HELM_SRC_PATH="$GOPATH/helmv3.8.0"
test -e "$HELM_SRC_PATH" && chmod -R 700 "$HELM_SRC_PATH"
test -e "$HELM_SRC_PATH" && rm -fr "$HELM_SRC_PATH"
cp -r $GOPATH/pkg/mod/helm.sh/helm/v3@v3.8.0 "$HELM_SRC_PATH"
chmod 700 "$HELM_SRC_PATH"
cd "$HELM_SRC_PATH"
make
cp "$HELM_SRC_PATH/bin/helm" "$GOPATH/bin/"

kind create cluster

kind delete cluster

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
