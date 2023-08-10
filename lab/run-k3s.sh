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

mkdir -p ./tmp
# bootstrap first server
ansible-playbook -i hosts.yml --limit=k3sprimary playbook-k3s.yml
# wait 2 min
sleep 120
# bootstrap the rest of the servers
ansible-playbook -i hosts.yml playbook-k3s.yml

cat <<EOF
Flannel is disabled, so need to install Calico for CNI with:

bash charts/run-tigera-operator.sh up
EOF
