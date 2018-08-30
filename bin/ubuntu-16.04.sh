#!/usr/bin/env bash
set -e
set -x
set -u

MY_DOCKER_IMAGE=git-ubuntu:16.04
MY_TMP_CONTEXT="${HOME}/docker-files/ubuntu/16.04"
MY_VOLUME_ARGS=""

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}
docker build --tag ${MY_DOCKER_IMAGE} .
cd -

if [ -e /usr/local/Cellar/bash-git-prompt/2.7.1 ]; then
  MY_VOLUME_ARGS="${MY_VOLUME_ARGS} --volume /usr/local/Cellar/bash-git-prompt/2.7.1:/usr/local/opt/bash-git-prompt:ro"
fi
if [ -e ${HOME}/.git ]; then
  MY_VOLUME_ARGS="${MY_VOLUME_ARGS} --volume ${HOME}/.git:/root/.git2:ro"
fi

docker run --rm \
  --interactive --tty \
  ${MY_VOLUME_ARGS} \
  ${MY_DOCKER_IMAGE} bash
