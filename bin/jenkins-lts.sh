#!/usr/bin/env bash
set -e
set -x
set -u

## See more docs at https://github.com/jenkinsci/docker/blob/master/README.md

# MY_DOCKER_IMAGE=jenkins/jenkins:lts
MY_DOCKER_IMAGE=jenkins/jenkins:2.107.1
MY_TMP_CONTEXT="tmpcontext-jenkins-2.107"

docker pull ${MY_DOCKER_IMAGE}

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > jenkins-lts.yml <<EOF
version: "3.5"

services:
  myjenkins:
    image: ${MY_DOCKER_IMAGE}
    ports:
      - 8080:8080
      - 50000:50000
    volumes:
      - jenkins_home:/var/jenkins_home

volumes:
  jenkins_home:
EOF
## Create and run the stack interactively
# docker-compose up
## Create and run the stack in the background
docker-compose up -d

## Destroy the stack and data
# docker-compose down --volumes
## Destroy the stack but keep the data
# docker-compose down
cd -
rm -r ${MY_TMP_CONTEXT}
