#!/usr/bin/env bash
set -eux

MY_TMP_CONTEXT="${HOME}/docker-files/squid"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

if which docker >/dev/null 2>&1 ; then
  DOCKER_BIN=docker
else
  if which podman >/dev/null 2>&1 ; then
    DOCKER_BIN=podman
  fi
fi

set +u
case ${1} in
get-ca)
  ## Extract the CA.pem so it can be used in client containers
  $DOCKER_BIN cp squid:/squid/certs/CA.pem ./
  ;;
down)
  ## Destroy the stack but keep the data
  $DOCKER_BIN compose down
  ;;
destroy)
  ## Destroy the stack and data
  $DOCKER_BIN compose down --volumes
  ;;
logs)
  $DOCKER_BIN compose logs
  ;;
ps)
  $DOCKER_BIN compose ps
  ;;
test-new)
  $DOCKER_BIN compose down --volumes
  $DOCKER_BIN compose build
  $DOCKER_BIN compose up --detach
  ;;
top)
  $DOCKER_BIN compose top
  ;;
up | *)
  $DOCKER_BIN compose build
  ## Create and run the stack interactively
  # $DOCKER_BIN compose up
  ## Create and run the stack in the background
  $DOCKER_BIN compose up --detach
  ;;
esac

cd -
