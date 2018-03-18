#!/usr/bin/env bash
set -e
set -x
set -u

##########

func_xcode_install ()
{
    ## Xcode (for git)
    xcode-select --install || true
    xcode-select --install 2>&1 | grep "already installed"
}

##########

func_homebrew_install ()
{
    ## Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

##########

func_curl_install ()
{
    ## Update curl
    brew install curl
    if [ ! -e /usr/local/bin/curl ]; then
        if [ $( ls /usr/local/Cellar/curl/ | wc -l ) -eq 1 ]; then
            CURL_VERSION=$(ls /usr/local/Cellar/curl/)
            ln -s ../Cellar/curl/${CURL_VERSION}/bin/curl /usr/local/bin/curl
        fi
    fi
}

##########

func_brew_pkgs ()
{
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
        shellcheck
        shfmt
        docker
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
        caskroom/cask/inkscape
        caskroom/cash/xquartz
        caskroom/cask/fugu
        caskroom/cask/keka
        caskroom/cask/shiftit
    "

    for i in ${BREW_PACKAGES}; do
        brew upgrade $i || brew install $i
    done
}

##########

func_npm_pkgs ()
{
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

func_gem_pkgs ()
{
    ## Temporary use Internet gem source
    printf -- "---\n:backtrace: false\n:bulk_threshold: 1000\n:update_sources: true\n:verbose: true\ngem: --no-ri --no-rdoc\nbenchmark: false\n" > ~/.gemrc

    ## Linting tools via Gem
    GEM_PACKAGES="
        puppet-lint
        bundler
    "

    gem install ${GEM_PACKAGES}
}

##########

func_bundle_cfg ()
{
    ## Setup use of Artifactory gem source
    set +u
    if [ -n "${GEM_SOURCE}" ]; then
        printf -- "---\n:backtrace: false\n:bulk_threshold: 1000\n:sources:\n- ${GEM_SOURCE}\n:update_sources: true\n:verbose: true\ngem: --no-ri --no-rdoc\nbenchmark: false\n" > ~/.gemrc
    fi
    set -u
    #bundle config ${artifactory_host} ${artifactory_username}:${artifactory_password}

    ## Now you can: bundle install
}

##########

func_puppet_cfg ()
{
    ## Configure puppet module_repository
    [ ! -d ~/.puppetlabs/etc/puppet ] && mkdir -p ~/.puppetlabs/etc/puppet
    [ ! -f ~/.puppetlabs/etc/puppet/puppet.conf ] && touch ~/.puppetlabs/etc/puppet/puppet.conf
    set +u
    if [ -n "${BEAKER_FORGE_HOST}" ]; then
        grep -q "module_repository" ~/.puppetlabs/etc/puppet/puppet.conf || printf -- "\n[main]\nmodule_repository=${BEAKER_FORGE_HOST}\n" >> ~/.puppetlabs/etc/puppet/puppet.conf
    fi
    set -u
}

##########

func_atom_pkgs ()
{
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

func_docker_pkgs ()
{
    ## Docker was installed by brew
    docker version

    ## Trusting a docker registry
    #DOCKER_REGISTRY_HOST="reg.my.domain"
    #DOCKER_REGISTRY_PORT="5001"
    #DOCKER_REGISTRY="${DOCKER_REGISTRY_HOST}:${DOCKER_REGISTRY_PORT}"
    #mkdir -p /etc/docker/certs.d/${DOCKER_REGISTRY}
    ## If you don't have the Root CA, you can trust the domain certificate as follows:
    #echo | openssl s_client -servername ${DOCKER_REGISTRY_HOST} -connect ${DOCKER_REGISTRY} 2>/dev/null | openssl x509 >> /etc/docker/certs.d/${DOCKER_REGISTRY}/ca.crt

    ## Set proxy for dockerd service so you can pull through proxy, e.g. if using docker-machine:
    #sudo tee /var/lib/boot2docker/profile <<EOF
#EXTRA_ARGS='
#--label provider=virtualbox
#
#'
#CACERT=/var/lib/boot2docker/ca.pem
#DOCKER_HOST='-H tcp://0.0.0.0:2376'
#DOCKER_STORAGE=aufs
#DOCKER_TLS=auto
#SERVERKEY=/var/lib/boot2docker/server-key.pem
#SERVERCERT=/var/lib/boot2docker/server.pem
#export HTTP_PROXY="${http_proxy}"
#export HTTPS_PROXY="${http_proxy}"
#export NO_PROXY="${no_proxy}"
#EOF

    ## Restart dockerd for proxy to take effect
}

##########

func_xcode_install
func_homebrew_install
func_curl_install
func_brew_pkgs
func_npm_pkgs
func_gem_pkgs
func_bundle_cfg
func_puppet_cfg
func_atom_pkgs
func_docker_pkgs

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
