#!/bin/bash
set -e
set +x
if [ "x" = "x$ANSIBLE_PASSWORD" ]; then
  echo "ERROR: Missing export ANSIBLE_PASSWORD=..."
  exit 1
fi
if [ "x" = "x$ANSIBLE_PASSWORD_MAC" ]; then
  echo "ERROR: Missing export ANSIBLE_PASSWORD_MAC=..."
  exit 1
fi
set -ux

ansible-playbook -i hosts.yml playbook-status.yml
