#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing suduoer.d..."

pushd $(dirname $0)

ansible-playbook -i localhost, ./playbook-bootstrap.yml

popd

echo "=>  Installation complete!"
