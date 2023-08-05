#!/bin/bash
set -e
set +x
if [ "x" = "x$ANSIBLE_PASSWORD" ]; then
  echo "ERROR: Missing export ANSIBLE_PASSWORD=..."
  exit 1
fi
if [ "x" = "x$LABCLUSTER_IP" ]; then
  echo "ERROR: Missing export LABCLUSTER_IP=..."
  exit 1
fi
set -ux

ansible-playbook -i hosts.yml playbook-bootstrap.yml
