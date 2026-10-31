# brew bundle

# macOS Apps
brew "mas"
cask "hammerspoon"
mas "Keynote", id: 361285480
mas "Numbers", id: 361304891
mas "Pages", id: 361309726

# Web Browsers
cask "google-chrome"

# Cloud / AWS
brew "awscli"

# Shell / CLI Tools
brew "gnupg"
brew "jq"
brew "tmux"
brew "ykman"
brew "yq"
cask "1password-cli"

# Docker / k8s
brew "podman"
cask "podman-desktop"
brew "docker-compose"

# Dev
cask "visual-studio-code"
brew "mise"
mas "Xcode", id: 497799835

# Lab / Virtualization
cask "utm" if Hardware::CPU.intel?

instance_eval(File.read(".Brewfile"))
