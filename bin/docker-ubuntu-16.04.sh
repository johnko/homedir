#!/usr/bin/env bash
set -e
set -x
set -u

MY_DOCKER_IMAGE=ubuntu:16.04
MY_TMP_CONTEXT="tmpcontext"
MY_VOLUME_ARGS=""

docker pull ${MY_DOCKER_IMAGE}

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > Dockerfile <<EOF
FROM ${MY_DOCKER_IMAGE}
RUN which apt-get && apt-get update && apt-get upgrade --yes && apt-get install --yes git
EOF
docker build --tag git-${MY_DOCKER_IMAGE} .
rm Dockerfile
cd -

if [ -e ${HOME}/.git ]; then
    MY_VOLUME_ARGS="${MY_VOLUME_ARGS} --volume ${HOME}/.git:/root/.git2:ro"
fi
if [ -e /usr/local/Cellar/bash-git-prompt/2.7.1 ]; then
    MY_VOLUME_ARGS="${MY_VOLUME_ARGS} --volume /usr/local/Cellar/bash-git-prompt/2.7.1:/usr/local/opt/bash-git-prompt:ro"
fi

docker run --rm --interactive --tty ${MY_VOLUME_ARGS} git-${MY_DOCKER_IMAGE} bash