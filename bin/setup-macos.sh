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
  brew tap homebrew/cask
}

##########

func_curl_install() {
  ## Update curl
  brew install curl
}

##########

func_brew_pkgs() {
  ## Brew packages
  BREW_PACKAGES="
    zsh-syntax-highlighting
    bash-completion
    bash-git-prompt
    git
    npm
    ruby
    rbenv
    go
    python@2
    python@3
    jq
    wget
    tmux
    shellcheck
    shfmt
    docker
    docker-credential-helper
    docker-compose-completion
    vagrant-completion
    watch
    iftop
    pv
    terminal-notifier
    "
  # brew remove ${BREW_PACKAGES} || true
  brew upgrade ${BREW_PACKAGES} || brew install ${BREW_PACKAGES}
  CASK_PACKAGES="
    shiftit
    iterm2
    atom
    visual-studio-code
    google-chrome
    firefox
    google-cloud-sdk
    docker
    aerial
    fugu
    keka
    spotify
    gimp
    vagrant
    virtualbox
    "
    #xquartz
    #inkscape
  # brew cask remove ${CASK_PACKAGES} || true
  brew cask upgrade ${CASK_PACKAGES} || brew cask install ${CASK_PACKAGES}
}

##########

func_zsh_install() {
  ## Oh My Zsh
  rm -fr ~/.oh-my-zsh
  git submodule update --init --depth=10
  cd ~/.oh-my-zsh
  git submodule update --init
  cd -
  ## Vim-Powerline fonts
  if [ -d fonts ] && [ -x fonts/install.sh ]; then
    cd fonts
    ./install.sh
    cd -
  fi
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
  gem install ${GEM_PACKAGES}
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

func_xcode_install
func_homebrew_install
func_curl_install
func_brew_pkgs
func_zsh_install
func_npm_pkgs
func_gem_pkgs
func_atom_pkgs

exit

##########

==> Pouring curl-7.62.0.mojave.bottle.tar.gz
==> Caveats
curl is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have curl first in your PATH run:
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.bash_profile

For compilers to find curl you may need to set:
  export LDFLAGS="-L/usr/local/opt/curl/lib"
  export CPPFLAGS="-I/usr/local/opt/curl/include"

##########

==> Caveats
==> zsh-syntax-highlighting
To activate the syntax highlighting, add the following at the end of your .zshrc:
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

If you receive "highlighters directory not found" error message,
you may need to add the following to your .zshenv:
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters
==> bash-completion
Add the following line to your ~/.bash_profile:
  [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> bash-git-prompt
You should add the following to your .bashrc (or .bash_profile):
  if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
  fi
==> gettext
gettext is keg-only, which means it was not symlinked into /usr/local,
because macOS provides the BSD gettext library & some software gets confused if both are in the library path.

If you need to have gettext first in your PATH run:
  echo 'export PATH="/usr/local/opt/gettext/bin:$PATH"' >> ~/.bash_profile

For compilers to find gettext you may need to set:
  export LDFLAGS="-L/usr/local/opt/gettext/lib"
  export CPPFLAGS="-I/usr/local/opt/gettext/include"

==> git
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions and functions have been installed to:
  /usr/local/share/zsh/site-functions

Emacs Lisp files have been installed to:
  /usr/local/share/emacs/site-lisp/git
==> icu4c
icu4c is keg-only, which means it was not symlinked into /usr/local,
because macOS provides libicucore.dylib (but nothing else).

If you need to have icu4c first in your PATH run:
  echo 'export PATH="/usr/local/opt/icu4c/bin:$PATH"' >> ~/.bash_profile
  echo 'export PATH="/usr/local/opt/icu4c/sbin:$PATH"' >> ~/.bash_profile

For compilers to find icu4c you may need to set:
  export LDFLAGS="-L/usr/local/opt/icu4c/lib"
  export CPPFLAGS="-I/usr/local/opt/icu4c/include"

For pkg-config to find icu4c you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/icu4c/lib/pkgconfig"

==> node
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> openssl
A CA file has been bootstrapped using certificates from the SystemRoots
keychain. To add additional certificates (e.g. the certificates added in
the System keychain), place .pem files in
  /usr/local/etc/openssl/certs

and run
  /usr/local/opt/openssl/bin/c_rehash

openssl is keg-only, which means it was not symlinked into /usr/local,
because Apple has deprecated use of OpenSSL in favor of its own TLS and crypto libraries.

If you need to have openssl first in your PATH run:
  echo 'export PATH="/usr/local/opt/openssl/bin:$PATH"' >> ~/.bash_profile

For compilers to find openssl you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl/include"

For pkg-config to find openssl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

==> readline
readline is keg-only, which means it was not symlinked into /usr/local,
because macOS provides the BSD libedit library, which shadows libreadline.
In order to prevent conflicts when programs look for libreadline we are
defaulting this GNU Readline installation to keg-only.

For compilers to find readline you may need to set:
  export LDFLAGS="-L/usr/local/opt/readline/lib"
  export CPPFLAGS="-I/usr/local/opt/readline/include"

==> ruby
By default, binaries installed by gem will be placed into:
  /usr/local/lib/ruby/gems/2.5.0/bin

You may want to add this to your PATH.

ruby is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have ruby first in your PATH run:
  echo 'export PATH="/usr/local/opt/ruby/bin:$PATH"' >> ~/.bash_profile

For compilers to find ruby you may need to set:
  export LDFLAGS="-L/usr/local/opt/ruby/lib"
  export CPPFLAGS="-I/usr/local/opt/ruby/include"

For pkg-config to find ruby you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

==> autoconf
Emacs Lisp files have been installed to:
  /usr/local/share/emacs/site-lisp/autoconf
==> go
A valid GOPATH is required to use the `go get` command.
If $GOPATH is not specified, $HOME/go will be used by default:
  https://golang.org/doc/code.html#GOPATH

You may wish to add the GOROOT-based install location to your PATH:
  export PATH=$PATH:/usr/local/opt/go/libexec/bin
==> sqlite
sqlite is keg-only, which means it was not symlinked into /usr/local,
because macOS provides an older sqlite3.

If you need to have sqlite first in your PATH run:
  echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.bash_profile

For compilers to find sqlite you may need to set:
  export LDFLAGS="-L/usr/local/opt/sqlite/lib"
  export CPPFLAGS="-I/usr/local/opt/sqlite/include"

For pkg-config to find sqlite you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

==> python@2
Pip and setuptools have been installed. To update them
  pip install --upgrade pip setuptools

You can install Python packages with
  pip install <package>

They will install into the site-package directory
  /usr/local/lib/python2.7/site-packages

See: https://docs.brew.sh/Homebrew-and-Python
==> tmux
Example configuration has been installed to:
  /usr/local/opt/tmux/share/tmux

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> docker
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> docker-compose-completion
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> vagrant-completion
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> iftop
iftop requires root privileges so you will need to run `sudo iftop`.
You should be certain that you trust any software you grant root privileges.
