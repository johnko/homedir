#!/bin/bash
set -e
set +x
if [ "x" = "x$ANSIBLE_PASSWORD" ]; then
  echo "ERROR: Missing export ANSIBLE_PASSWORD=..."
  exit 1
fi
set -ux

mkdir -p ./tmp
ansible-playbook -i hosts.yml playbook-k3s.yml
