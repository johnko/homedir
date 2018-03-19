#!/usr/bin/env bash
set -e
set -x
set -u

MY_DOCKER_IMAGE=jenkins:2.60.3

docker pull ${MY_DOCKER_IMAGE}

docker run --detach \
    --name myjenkins \
    --publish 8080:8080 --publish 50000:50000 \
    --volume /var/jenkins_home ${MY_DOCKER_IMAGE}
