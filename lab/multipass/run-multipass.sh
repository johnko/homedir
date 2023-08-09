#!/bin/sh
set -eux

IMAGE=22.04
NIC=en2

multipass set local.bridged-network=$NIC

multipass launch \
  --name vm1 \
  --cpus 4 \
  --memory 16G \
  --disk 250G \
  --bridged \
  $IMAGE
