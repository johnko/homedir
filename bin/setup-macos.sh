#!/usr/bin/env bash
set -e
set -x
set -u

##########

func_xcode_install() {
  ## Xcode (for git)
  xcode-select --install || true
  xcode-select --install 2>&1 | grep "already installed"
}

##########

func_homebrew_install() {

  ## Homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew tap caskroom/cask

}

##########

func_curl_install() {
  ## Update curl
  brew install curl
  if [ ! -e /usr/local/bin/curl ]; then
    if [ $(ls /usr/local/Cellar/curl/ | wc -l) -eq 1 ]; then
      CURL_VERSION=$(ls /usr/local/Cellar/curl/)
      ln -s ../Cellar/curl/${CURL_VERSION}/bin/curl /usr/local/bin/curl
    fi
  fi
}

##########

func_brew_pkgs() {
  ## Brew packages
  BREW_PACKAGES="
    bash-completion
    bash-git-prompt
    git
    npm
    ruby
    go
    jq
    wget
    tmux
    caskroom/cask/google-chrome
    caskroom/cask/firefox
    caskroom/cask/atom
    caskroom/cask/iterm2
    homebrew/cask/visual-studio-code
    shellcheck
    shfmt
    docker
    caskroom/cask/docker
    docker-credential-helper
    docker-compose-completion
    caskroom/cask/virtualbox
    caskroom/cask/vagrant
    vagrant-completion
    caskroom/cask/spotify
    watch
    iftop
    terminal-notifier
    caskroom/cask/gimp
    caskroom/cask/xquartz
    caskroom/cask/inkscape
    caskroom/cask/fugu
    caskroom/cask/keka
    caskroom/cask/shiftit
    pv
    "

  for i in ${BREW_PACKAGES}; do
    brew upgrade $i || brew install $i
  done
}

##########

func_npm_pkgs() {
  ## Update npm
  npm install --global npm

  ## Linting tools via NPM
  NPM_PACKAGES="
    standard
    yaml-js
    "

  npm install --global ${NPM_PACKAGES}
}

##########

func_gem_pkgs() {
  ## Linting tools via Gem
  GEM_PACKAGES="
    puppet-lint
    bundler
    "

  ## https://bundler.io/v1.16/guides/rubygems_tls_ssl_troubleshooting_guide.html

  /usr/local/bin/gem install ${GEM_PACKAGES}
}

##########

func_atom_pkgs() {
  ## Atom Editor packages
  ATOM_PACKAGES="
    linter
    linter-ui-default
    intentions
    busy-signal
    linter-shellcheck
    format-shell
    linter-ruby
    linter-erb
    linter-python
    linter-js-yaml
    linter-js-standard
    language-puppet
    linter-puppet-lint
    atom-alignment
    "

  apm install ${ATOM_PACKAGES}
}

##########

func_zsh_install() {
  ## Oh My Zsh
  set +x
  echo sh -c "(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  set -x
  git submodule update --init
  ## Vim-Powerline fonts
  if [ -d fonts ] && [ -x fonts/install.sh ]; then
    cd fonts
    ./install.sh
  fi
}

##########

func_xcode_install
func_homebrew_install
func_zsh_install
func_curl_install
func_brew_pkgs
func_npm_pkgs
func_gem_pkgs
func_atom_pkgs

exit

##########

## Example configuration has been installed to:
##   /usr/local/opt/tmux/share/tmux

## A valid GOPATH is required to use the `go get` command.
## If $GOPATH is not specified, $HOME/go will be used by default:
##   https://golang.org/doc/code.html#GOPATH
## You may wish to add the GOROOT-based install location to your PATH:
##   export PATH=$PATH:/usr/local/opt/go/libexec/bin

## A CA file has been bootstrapped using certificates from the SystemRoots
## keychain. To add additional certificates (e.g. the certificates added in
## the System keychain), place .pem files in
##   /usr/local/etc/openssl/certs
## and run
##   /usr/local/opt/openssl/bin/c_rehash

## For compilers to find this software you may need to set:
##     LDFLAGS:  -L/usr/local/opt/curl/lib
##     CPPFLAGS: -I/usr/local/opt/curl/include
## For compilers to find this software you may need to set:
##     LDFLAGS:  -L/usr/local/opt/openssl/lib
##     CPPFLAGS: -I/usr/local/opt/openssl/include
