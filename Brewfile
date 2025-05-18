# brew bundle

# macOS Apps
brew "mas"
cask "gimp"
cask "rectangle"
mas "Keynote", id: 409183694
mas "Numbers", id: 409203825
mas "Pages", id: 409201541

# Web Browsers
cask "brave-browser"
cask "firefox"
cask "google-chrome"

# Cloud / AWS
brew "aws-vault"
brew "awscli"
tap "hashicorp/tap"
brew "hashicorp/tap/terraform"
brew "tflint"
cask "sentinel"

# Shell / CLI Tools
brew "fx"
brew "gnupg"
brew "jless"
brew "jq"
brew "tmux"
brew "ykman"
brew "yq"
cask "1password-cli"

# Docker / k8s
brew "podman"
cask "podman-desktop"
brew "docker-compose"
brew "helm"
brew "k9s"
brew "kind"
brew "kubernetes-cli"
cask "kui"

# Dev
cask "visual-studio-code"
tap "wix/brew"
brew "wix/brew/applesimutils"
brew "mise"
brew "openjdk"
brew "watchman"
cask "android-studio"
cask "android-commandlinetools"
cask "android-platform-tools"
mas "Xcode", id: 497799835

# AI
cask "ollama"

# VS Code extensions
vscode "continue.continue"
vscode "davidanson.vscode-markdownlint"
vscode "dbaeumer.vscode-eslint"
vscode "docsmsft.docs-article-templates"
vscode "docsmsft.docs-markdown"
vscode "docsmsft.docs-preview"
vscode "docsmsft.docs-scaffolding"
vscode "docsmsft.docs-yaml"
vscode "eamodio.gitlens"
vscode "github.remotehub"
vscode "github.vscode-github-actions"
vscode "github.vscode-pull-request-github"
vscode "golang.go"
vscode "hashicorp.hcl"
vscode "hashicorp.sentinel"
vscode "hashicorp.terraform"
vscode "ibm.output-colorizer"
vscode "ms-azuretools.vscode-docker"
vscode "ms-kubernetes-tools.kind-vscode"
vscode "ms-kubernetes-tools.vscode-kubernetes-tools"
vscode "ms-ossdata.vscode-postgresql"
vscode "ms-python.black-formatter"
vscode "ms-python.debugpy"
vscode "ms-python.flake8"
vscode "ms-python.isort"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-vscode-remote.remote-containers"
vscode "ms-vscode-remote.remote-ssh"
vscode "ms-vscode-remote.remote-ssh-edit"
vscode "ms-vscode.azure-repos"
vscode "ms-vscode.hexeditor"
vscode "ms-vscode.makefile-tools"
vscode "ms-vscode.remote-explorer"
vscode "ms-vscode.remote-repositories"
vscode "msjsdiag.vscode-react-native"
vscode "redhat.ansible"
vscode "redhat.vscode-xml"
vscode "redhat.vscode-yaml"

# Lab / Virtualization
cask "utm" if Hardware::CPU.intel?

instance_eval(File.read(".Brewfile"))
