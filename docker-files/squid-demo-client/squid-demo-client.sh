#!/usr/bin/env bash
set -eux

MY_TMP_CONTEXT="${HOME}/docker-files/squid-demo-client"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

if which docker >/dev/null 2>&1 ; then
  DOCKER_BIN=docker
else
  if which podman >/dev/null 2>&1 ; then
    DOCKER_BIN=podman
  fi
fi

get_ca() {
  ## Extract the CA.pem from squid so it can be used in client containers
  $DOCKER_BIN cp squid:/squid/certs/CA.pem ./
}

set +u
case ${1} in
up | *)
  get_ca
  $DOCKER_BIN build . --tag demo:squid-client
  set +x
  echo "Try something like:"
  echo "  npm install --verbose --global npm @swc/cli"
  set -x
  $DOCKER_BIN run --rm -it --network host --entrypoint sh demo:squid-client
  ;;
esac

cd -
