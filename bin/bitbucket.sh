#!/usr/bin/env bash
set -e
set -x
set -u

## See more docs at https://hub.docker.com/r/atlassian/bitbucket-server/


MY_DOCKER_IMAGE=atlassian/bitbucket:5.8.1
MY_TMP_CONTEXT="tmpcontext-bitbucket-5.8"

docker pull ${MY_DOCKER_IMAGE}

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > docker-compose.yml <<EOF
version: "3.5"

services:
  mybitbucket:
    image: ${MY_DOCKER_IMAGE}
    ports:
      - 127.0.0.1:7990:7990
      - 127.0.0.1:7999:7999
    volumes:
      - bitbucketVolume:/var/atlassian/application-data/bitbucket

volumes:
  bitbucketVolume:
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
