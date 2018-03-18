#!/usr/bin/env bash
set -e
set -x
set -u

MY_DOCKER_IMAGE=ubuntu:16.04

docker pull ${MY_DOCKER_IMAGE}
docker run --rm ${MY_DOCKER_IMAGE} bash
