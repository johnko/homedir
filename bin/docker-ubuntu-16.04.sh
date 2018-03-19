#!/usr/bin/env bash
set -e
set -x
set -u

MY_DOCKER_IMAGE=ubuntu:16.04

docker pull ${MY_DOCKER_IMAGE}
if [ -e ${HOME}/.git ]; then
    MY_VOLUME_ARGS="--volume ${HOME}/.git:/root/.git2:ro"
else
    MY_VOLUME_ARGS=""
fi
docker run --rm --interactive --tty ${MY_VOLUME_ARGS} ${MY_DOCKER_IMAGE} bash
