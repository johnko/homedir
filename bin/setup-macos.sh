#!/usr/bin/env bash
set -eux

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
  # brew tap caskroom/cask
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
    bash-completion
    bash-git-prompt
    docker
    docker-compose-completion
    docker-credential-helper
    git
    go
    iftop
    jq
    kind
    pv
    python3
    shellcheck
    shfmt
    terminal-notifier
    tmux
    vagrant-completion
    watch
    wget
    zsh-syntax-highlighting
    "
    # npm
    # rbenv
  # brew remove ${BREW_PACKAGES} || true
  brew install ${BREW_PACKAGES}
}

##########

func_cask_pkgs() {
  CASK_PACKAGES="
    docker
    firefox
    gimp
    google-chrome
    hammerspoon
    spotify
    vagrant
    virtualbox
    visual-studio-code
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
func_homebrew_install
func_curl_install
func_brew_pkgs
func_cask_pkgs
# # func_zsh_install
# # func_npm_pkgs
# # func_gem_pkgs
# # func_atom_pkgs

exit

##########

==> Caveats
==> openssl@1.1
A CA file has been bootstrapped using certificates from the system
keychain. To add additional certificates, place .pem files in
  /usr/local/etc/openssl@1.1/certs

and run
  /usr/local/opt/openssl@1.1/bin/c_rehash

openssl@1.1 is keg-only, which means it was not symlinked into /usr/local,
because macOS provides LibreSSL.

If you need to have openssl@1.1 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"' >> ~/.profile

For compilers to find openssl@1.1 you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

==> openldap
openldap is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have openldap first in your PATH, run:
  echo 'export PATH="/usr/local/opt/openldap/bin:$PATH"' >> ~/.profile
  echo 'export PATH="/usr/local/opt/openldap/sbin:$PATH"' >> ~/.profile

For compilers to find openldap you may need to set:
  export LDFLAGS="-L/usr/local/opt/openldap/lib"
  export CPPFLAGS="-I/usr/local/opt/openldap/include"

==> curl
curl is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have curl first in your PATH, run:
  echo 'export PATH="/usr/local/opt/curl/bin:$PATH"' >> ~/.profile

For compilers to find curl you may need to set:
  export LDFLAGS="-L/usr/local/opt/curl/lib"
  export CPPFLAGS="-I/usr/local/opt/curl/include"

##########

==> Caveats
==> bash-completion
Add the following line to your ~/.bash_profile:
  [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> bash-git-prompt
You should add the following to your .bashrc (or .bash_profile):
  if [ -f "/usr/local/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    __GIT_PROMPT_DIR="/usr/local/opt/bash-git-prompt/share"
    source "/usr/local/opt/bash-git-prompt/share/gitprompt.sh"
  fi
==> docker
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> docker-compose-completion
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> git
The Tcl/Tk GUIs (e.g. gitk, git-gui) are now in the `git-gui` formula.

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

Emacs Lisp files have been installed to:
  /usr/local/share/emacs/site-lisp/git
==> iftop
iftop requires root privileges so you will need to run `sudo iftop`.
You should be certain that you trust any software you grant root privileges.
==> kind
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> readline
readline is keg-only, which means it was not symlinked into /usr/local,
because macOS provides BSD libedit.

For compilers to find readline you may need to set:
  export LDFLAGS="-L/usr/local/opt/readline/lib"
  export CPPFLAGS="-I/usr/local/opt/readline/include"

==> sqlite
sqlite is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have sqlite first in your PATH, run:
  echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.profile

For compilers to find sqlite you may need to set:
  export LDFLAGS="-L/usr/local/opt/sqlite/lib"
  export CPPFLAGS="-I/usr/local/opt/sqlite/include"

==> python@3.9
Python has been installed as
  /usr/local/bin/python3

Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
`python3`, `python3-config`, `pip3` etc., respectively, have been installed into
  /usr/local/opt/python@3.9/libexec/bin

You can install Python packages with
  pip3 install <package>
They will install into the site-package directory
  /usr/local/lib/python3.9/site-packages

tkinter is no longer included with this formula, but it is available separately:
  brew install python-tk@3.9

See: https://docs.brew.sh/Homebrew-and-Python
==> ncurses
ncurses is keg-only, which means it was not symlinked into /usr/local,
because macOS already provides this software and installing another version in
parallel can cause all kinds of trouble.

If you need to have ncurses first in your PATH, run:
  echo 'export PATH="/usr/local/opt/ncurses/bin:$PATH"' >> ~/.profile

For compilers to find ncurses you may need to set:
  export LDFLAGS="-L/usr/local/opt/ncurses/lib"
  export CPPFLAGS="-I/usr/local/opt/ncurses/include"

==> tmux
Example configuration has been installed to:
  /usr/local/opt/tmux/share/tmux

Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> vagrant-completion
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d
==> zsh-syntax-highlighting
To activate the syntax highlighting, add the following at the end of your .zshrc:
  source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

If you receive "highlighters directory not found" error message,
you may need to add the following to your .zshenv:
  export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

##########

==> Caveats
virtualbox requires a kernel extension to work.
If the installation fails, retry after you enable it in:
  System Preferences → Security & Privacy → General

For more information, refer to vendor documentation or this Apple Technical Note:
  https://developer.apple.com/library/content/technotes/tn2459/_index.html
