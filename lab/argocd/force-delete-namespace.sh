#!/bin/bash
set -eux

# https://stackoverflow.com/questions/52369247/namespace-stuck-as-terminating-how-i-removed-it

NAMESPACE=$1

kubectl get namespace $NAMESPACE -o json \
| jq '.spec = {"finalizers":[]}' \
| kubectl replace --raw /api/v1/namespaces/$NAMESPACE/finalize -f -
