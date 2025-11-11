#!/usr/bin/env bash
set -euo pipefail

if type docker &>/dev/null; then
  DOCKER_BIN=docker
else
  if type podman &>/dev/null; then
    DOCKER_BIN=podman
  fi
fi

set -x

$DOCKER_BIN run --rm --interactive --tty --entrypoint bash ubuntu:24.04
