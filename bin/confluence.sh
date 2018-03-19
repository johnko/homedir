#!/usr/bin/env bash
set -e
set -x
set -u

## See more docs at https://hub.docker.com/r/atlassian/confluence-server/


MY_DOCKER_IMAGE=atlassian/confluence-server:6.7.2
MY_TMP_CONTEXT="tmpcontext-confluence-6.7"

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > docker-compose.yml <<EOF
version: "3.5"

services:
  myconfluence:
    container_name: myconfluence
    image: ${MY_DOCKER_IMAGE}
    ports:
      - 127.0.0.1:8090:8090
      - 127.0.0.1:8091:8091
    restart: always
    volumes:
      - confluence_data:/var/atlassian/application-data/confluence

volumes:
  confluence_data:
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
