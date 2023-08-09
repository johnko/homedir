#!/bin/sh
set -eux

IMAGE=22.04
NIC=en2

multipass set local.driver=qemu

multipass launch \
  -vvv \
  --name vm1 \
  --cpus 4 \
  --memory 16G \
  --disk 250G \
  --network "name=$NIC,mode=auto" \
  --cloud-init=./cloud-init.yaml \
  $IMAGE
