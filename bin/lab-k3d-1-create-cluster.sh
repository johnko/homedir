#!/usr/bin/env bash
set -eux

# reference: https://k3d.io/v5.5.1/usage/multiserver/

CLUSTER_NAME="lab"
IP_ADDRESS="192.168.2.249"
TOKEN="$1"

k3d cluster create \
  $CLUSTER_NAME \
  --servers 1 \
  --k3s-arg "--cluster-init@server:0" \
  --k3s-arg "--advertise-address=$IP_ADDRESS@server:0" \
  --k3s-arg "--tls-san=$IP_ADDRESS@server:0" \
  --port "6443:6443@server:0:direct" \
  --token $TOKEN \
  --wait

# -v /my/path@agent:0,1 -v /tmp/test:/tmp/other@server:0
