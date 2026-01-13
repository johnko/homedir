#!/usr/bin/env bash
set -eo pipefail

case $1 in
  on | ON | enable | ENABLE | yes | YES)
    export ANSIBLE_ACTION="present"
    ;;
  *)
    export ANSIBLE_ACTION="absent"

    # we have passwordless sudo, so we can make a symlink to the bin directory
    set -x
    if [[ $USER =~ ^j ]]; then
      if [[ ! -e /Users/john ]]; then
        sudo install -d -o "$USER" -m 700 /Users/john
      fi
      if [[ ! -e /Users/john/bin ]]; then
        ln -sf "$HOME/bin" /Users/john/bin
      fi
    fi
    set +x
    ;;
esac

set -u

echo "=>  Installing sudoers.d..."
echo "=>  - ANSIBLE_ACTION=$ANSIBLE_ACTION"

pushd "$(dirname "$0")"

set +e
set -x

export ANSIBLE_BECOME="false"
ansible-playbook --check --diff -i localhost, ./playbook-sudo-nopasswd.yml

set -e

export ANSIBLE_BECOME="true"
ansible-playbook --ask-become-pass -i localhost, ./playbook-sudo-nopasswd.yml

set +x

popd

echo "=>  Installation complete!"
