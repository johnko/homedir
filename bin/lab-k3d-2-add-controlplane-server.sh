#!/usr/bin/env bash
set -eux

# reference: https://k3d.io/v5.5.1/usage/multiserver/

CLUSTER_NAME="https://192.168.2.249:6443"
IP_ADDRESS="192.168.2.234"
TOKEN="$1"

k3d node create newserver \
  --cluster $CLUSTER_NAME \
  --role server \
  --k3s-arg "--advertise-address=$IP_ADDRESS@server:1" \
  --k3s-arg "--tls-san=$IP_ADDRESS@server:1" \
  --port "6443:6443@server:1:direct" \
  --token $TOKEN \
  --wait
