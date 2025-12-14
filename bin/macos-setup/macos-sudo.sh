#!/usr/bin/env bash
set -eo pipefail

case $1 in
  on | ON | enable | ENABLE | yes | YES)
    export ANSIBLE_ACTION="present"
    ;;
  *)
    export ANSIBLE_ACTION="absent"
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
