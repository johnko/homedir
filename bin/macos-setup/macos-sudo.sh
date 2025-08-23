#!/usr/bin/env bash
set -eo pipefail

case $1 in
  on|ON|enable|ENABLE|yes|YES)
    export ANSIBLE_ACTION=present
    ;;
  *)
    export ANSIBLE_ACTION=absent
    ;;
esac

set -u
echo "=>  Installing suduoer.d..."

pushd $(dirname $0)

set -x

echo "ANSIBLE_ACTION=$ANSIBLE_ACTION"
ansible-playbook --ask-become-pass -i localhost, ./playbook-sudo-nopasswd.yml

set +x

popd

echo "=>  Installation complete!"
