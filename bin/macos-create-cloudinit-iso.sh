#!/usr/bin/env bash
set -eux

if which docker >/dev/null 2>&1 ; then
  DOCKER_BIN=docker
else
  if which podman >/dev/null 2>&1 ; then
    DOCKER_BIN=podman
  fi
fi

UBUNTU_CONTAINER_ID=$($DOCKER_BIN ps | grep ubuntu:24.04 | cut -d' ' -f1)

# https://canonical-subiquity.readthedocs-hosted.com/en/latest/howto/autoinstall-quickstart.html

$DOCKER_BIN exec $UBUNTU_CONTAINER_ID apt update
$DOCKER_BIN exec $UBUNTU_CONTAINER_ID apt install -y cloud-image-utils
$DOCKER_BIN exec $UBUNTU_CONTAINER_ID mkdir -p cidata
$DOCKER_BIN exec $UBUNTU_CONTAINER_ID touch ./cidata/meta-data
$DOCKER_BIN cp $(dirname $0)/cloud-init.yaml $UBUNTU_CONTAINER_ID:./cidata/user-data
$DOCKER_BIN exec $UBUNTU_CONTAINER_ID bash -c "cd cidata && cloud-localds ../cloudinit.iso user-data meta-data"
$DOCKER_BIN cp $UBUNTU_CONTAINER_ID:./cloudinit.iso ${HOME}/iso/cloudinit.iso
