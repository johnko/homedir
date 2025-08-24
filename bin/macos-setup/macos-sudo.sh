#!/usr/bin/env bash
set -eo pipefail

case $1 in
  on|ON|enable|ENABLE|yes|YES)
    export ANSIBLE_ACTION="present"
    ;;
  *)
    export ANSIBLE_ACTION="absent"
    ;;
esac

set -u

echo "=>  Installing sudoers.d..."
echo "=>  - ANSIBLE_ACTION=$ANSIBLE_ACTION"

pushd $(dirname $0)


export ANSIBLE_BECOME="false"
if ! ansible-playbook -i localhost, ./playbook-sudo-nopasswd.yml ; then
  export ANSIBLE_BECOME="true"
  set -x
  ansible-playbook --ask-become-pass -i localhost, ./playbook-sudo-nopasswd.yml
fi

set +x

popd

echo "=>  Installation complete!"
