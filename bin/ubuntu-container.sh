#!/usr/bin/env bash
set -eux

if which docker >/dev/null 2>&1 ; then
  DOCKER_BIN=docker
else
  if which podman >/dev/null 2>&1 ; then
    DOCKER_BIN=podman
  fi
fi

$DOCKER_BIN run --rm --interactive --tty --entrypoint bash ubuntu:24.04
