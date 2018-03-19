#!/usr/bin/env bash
set -e
set -x
set -u

MY_DOCKER_IMAGE=ubuntu:16.04
MY_TMP_CONTEXT="tmpcontext-ubuntu-16.04"
MY_VOLUME_ARGS=""

docker pull ${MY_DOCKER_IMAGE}

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > .bashrc <<EOF
if [ -e /root/.git2 ]; then
    cd /root
    cp -a .git2 .git
    git reset --hard
    rm -r .git
    source .profile
else
    [ -e /root/.bashrc2 ] && source /root/.bashrc2
fi
EOF
cat > Dockerfile <<EOF
FROM ${MY_DOCKER_IMAGE}
RUN which apt-get && apt-get update && apt-get upgrade --yes && apt-get install --yes git
RUN cp -a /root/.bashrc /root/.bashrc2
COPY .bashrc /root/.bashrc
EOF
docker build --tag git-${MY_DOCKER_IMAGE} .
cd -
rm -r ${MY_TMP_CONTEXT}

if [ -e /usr/local/Cellar/bash-git-prompt/2.7.1 ]; then
    MY_VOLUME_ARGS="${MY_VOLUME_ARGS} --volume /usr/local/Cellar/bash-git-prompt/2.7.1:/usr/local/opt/bash-git-prompt:ro"
fi
if [ -e ${HOME}/.git ]; then
    MY_VOLUME_ARGS="${MY_VOLUME_ARGS} --volume ${HOME}/.git:/root/.git2:ro"
fi

docker run --rm \
    --interactive --tty \
    ${MY_VOLUME_ARGS} \
    git-${MY_DOCKER_IMAGE} bash
