#!/usr/bin/env bash
set -euo pipefail

# MacOS
brew install --cask visual-studio-code

if [ ! -e /usr/local/bin/code ] ; then
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
ms-toolsai.jupyter
redhat.vscode-xml
oderwat.indent-rainbow
tomoyukim.vscode-mermaid-editor
"

for ext in $EXTENSIONS; do
  echo "=>  Installing extension: $ext"
  /usr/local/bin/code --install-extension $ext
done

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
