#!/bin/bash
set -e
set +x
if [ "x" = "x$ANSIBLE_PASSWORD" ]; then
  echo "ERROR: Missing export ANSIBLE_PASSWORD=..."
  exit 1
fi
set -ux

ansible-playbook -i hosts.yml playbook-k3s-postgres.yml
mkdir -p ./tmp
scp stick2:/etc/ssl/pgsql-server.pem ./tmp/pgsql-server.pem
ansible-playbook -i hosts.yml playbook-k3s-servers.yml
