#!/usr/bin/env bash
set -euo pipefail

echo "=>  Installing suduoer.d..."

pushd $(dirname $0)

set -x

ansible-playbook -i localhost, ./playbook-bootstrap.yml

set +x

popd

echo "=>  Installation complete!"
