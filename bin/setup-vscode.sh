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
docsmsft.docs-article-templates
docsmsft.docs-authoring-pack
docsmsft.docs-build
docsmsft.docs-images
docsmsft.docs-linting
docsmsft.docs-markdown
docsmsft.docs-metadata
docsmsft.docs-preview
docsmsft.docs-scaffolding
docsmsft.docs-yaml
golang.go
Gruntfuggly.todo-tree
hashicorp.hcl
hashicorp.sentinel
hashicorp.terraform
IBM.output-colorizer
johnpapa.vscode-peacock
ms-azuretools.vscode-docker
ms-kubernetes-tools.kind-vscode
ms-kubernetes-tools.vscode-kubernetes-tools
ms-ossdata.vscode-postgresql
ms-python.black-formatter
ms-python.isort
ms-python.python
ms-python.vscode-pylance
ms-vscode-remote.remote-containers
ms-vscode.hexeditor
ms-vscode.makefile-tools
ms-vsliveshare.vsliveshare
ms-vsliveshare.vsliveshare-pack
msjsdiag.vscode-react-native
oderwat.indent-rainbow
redhat.ansible
redhat.vscode-xml
redhat.vscode-yaml
"
# ms-toolsai.jupyter
# tomoyukim.vscode-mermaid-editor

for ext in $EXTENSIONS; do
  echo "=>  Installing extension: $ext"
  code --install-extension $ext
done

echo "=>  Installation complete!"

echo "=>  Setup is complete!"
