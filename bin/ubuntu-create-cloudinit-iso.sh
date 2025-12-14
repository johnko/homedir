#!/usr/bin/env bash
set -euo pipefail

if type docker &>/dev/null; then
  DOCKER_BIN=docker
else
  if type podman &>/dev/null; then
    DOCKER_BIN=podman
  fi
fi

UBUNTU_CONTAINER_ID=$($DOCKER_BIN ps | grep ubuntu:24.04 | cut -d' ' -f1)

set -x

# https://canonical-subiquity.readthedocs-hosted.com/en/latest/howto/autoinstall-quickstart.html

$DOCKER_BIN exec "$UBUNTU_CONTAINER_ID" apt update
$DOCKER_BIN exec "$UBUNTU_CONTAINER_ID" apt install -y cloud-image-utils
$DOCKER_BIN exec "$UBUNTU_CONTAINER_ID" mkdir -p cloudinit
$DOCKER_BIN exec "$UBUNTU_CONTAINER_ID" touch ./cloudinit/meta-data
$DOCKER_BIN cp "$(dirname "$0")/vm/cloud-init.yaml" "$UBUNTU_CONTAINER_ID:./cloudinit/user-data"
$DOCKER_BIN exec "$UBUNTU_CONTAINER_ID" bash -c "cd cloudinit && cloud-localds ../cloudinit.iso user-data meta-data"
$DOCKER_BIN cp "$UBUNTU_CONTAINER_ID:./cloudinit.iso" "${HOME}/iso/cloudinit.iso"
