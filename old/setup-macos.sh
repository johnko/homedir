#!/usr/bin/env bash
set -eux

##########

func_xcode_install() {
  ## Xcode (for git)
  xcode-select --install || true
  xcode-select --install 2>&1 | grep "already installed"
}

##########

func_git_submodules() {
  git submodule init
  git submodule update
}

##########

func_homebrew_install() {
  ## Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  # brew tap caskroom/cask
  # brew tap homebrew/cask
}

##########

func_brew_pkgs() {
  ## Brew packages
  BREW_PACKAGES="
    bash-completion
    docker-compose-completion
    iftop
    pv
    shellcheck
    shfmt
    terminal-notifier
    vagrant-completion
    watch
    zsh-syntax-highlighting
    "
  # brew remove ${BREW_PACKAGES} || true
  brew install ${BREW_PACKAGES}
}

##########

func_cask_pkgs() {
  CASK_PACKAGES="
    steam
    vagrant
    "
    # google-cloud-sdk
    # fugu
    # keka
    # xquartz
    # inkscape
  # brew cask remove ${CASK_PACKAGES} || true
  brew install --cask ${CASK_PACKAGES}
}

##########

# func_zsh_install() {
#   ## Oh My Zsh
#   rm -fr ~/.oh-my-zsh
#   git submodule update --init --depth=10
#   cd ~/.oh-my-zsh
#   git submodule update --init
#   cd -
#   ## Vim-Powerline fonts
#   if [ -d fonts ] && [ -x fonts/install.sh ]; then
#     cd fonts
#     ./install.sh
#     cd -
#   fi
# }

##########

# func_npm_pkgs() {
#   ## Update npm
#   npm install --global npm
#   ## Linting tools via NPM
#   NPM_PACKAGES="
#     standard
#     yaml-js
#     "
#   npm install --global ${NPM_PACKAGES}
# }

##########

# func_gem_pkgs() {
#   ## Linting tools via Gem
#   GEM_PACKAGES="
#     puppet-lint
#     bundler
#     "
#   ## https://bundler.io/v1.16/guides/rubygems_tls_ssl_troubleshooting_guide.html
#   gem install ${GEM_PACKAGES}
# }

##########

# func_atom_pkgs() {
#   ## Atom Editor packages
#   ATOM_PACKAGES="
#     linter
#     linter-ui-default
#     intentions
#     busy-signal
#     linter-shellcheck
#     format-shell
#     linter-ruby
#     linter-erb
#     linter-python
#     linter-js-yaml
#     linter-js-standard
#     language-puppet
#     linter-puppet-lint
#     atom-alignment
#     "
#   apm install ${ATOM_PACKAGES}
# }

##########

func_xcode_install
func_git_submodules
func_homebrew_install
func_brew_pkgs
func_cask_pkgs
# # func_zsh_install
# # func_npm_pkgs
# # func_gem_pkgs
# # func_atom_pkgs
