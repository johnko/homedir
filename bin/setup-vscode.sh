#!/usr/bin/env bash
set -euo pipefail

# MacOS
# brew install --cask visual-studio-code

export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin

if ! which code ; then
  echo "!!  Failed to install visual-studio-code"
  exit 1
fi

EXTENSIONS="
ms-vsliveshare.vsliveshare-pack
docsmsft.docs-authoring-pack
ms-kubernetes-tools.kind-vscode
ms-kubernetes-tools.vscode-kubernetes-tools
redhat.vscode-yaml
ms-azuretools.vscode-docker
golang.go
ms-python.python
redhat.vscode-xml
ms-vscode-remote.remote-containers
hashicorp.terraform
oderwat.indent-rainbow
"
# ms-toolsai.jupyter
# tomoyukim.vscode-mermaid-editor

for ext in $EXTENSIONS; do
  echo "=>  Installing extension: $ext"
  code --install-extension $ext
done

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
