#!/usr/bin/env bash
set -e
set -x
set -u

## See more docs at https://github.com/jenkinsci/docker/blob/master/README.md

# MY_DOCKER_IMAGE=jenkins/jenkins:lts
MY_DOCKER_IMAGE=jenkins/jenkins:2.107.1
MY_TMP_CONTEXT="tmpcontext-jenkins-2.107"

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > docker-compose.yml <<EOF
version: "3.5"

services:
  myjenkins:
    container_name: myjenkins
    image: ${MY_DOCKER_IMAGE}
    ports:
      - 127.0.0.1:8080:8080
      - 127.0.0.1:50000:50000
    restart: always
    volumes:
      - jenkins_home:/var/jenkins_home

volumes:
  jenkins_home:
EOF

set +u
case ${1} in
    stop)
        ## Destroy the stack but keep the data
        docker-compose down
        ;;
    destroy)
        ## Destroy the stack and data
        docker-compose down --volumes
        ;;
    start|*)
        docker-compose pull
        ## Create and run the stack interactively
        # docker-compose up
        ## Create and run the stack in the background
        docker-compose up -d
        ;;
esac

cd -
rm -r ${MY_TMP_CONTEXT}
