#!/usr/bin/env bash
set -e
set -x
set -u

## See more docs at https://docs.gitea.io/en-us/install-with-docker/  or  https://docs.gitea.io/en-us/config-cheat-sheet/


MY_DOCKER_IMAGE=gitea/gitea:1.3.3
MY_TMP_CONTEXT="tmpcontext-gitea-1.3"

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > docker-compose.yml <<EOF
version: "3.5"

services:
  mygitea-db:
    container_name: mygitea-db
    image: postgres:9.5
    environment:
      - POSTGRES_USER=gitea
      - POSTGRES_PASSWORD=gitea
      - POSTGRES_DB=gitea
    restart: always
    volumes:
      - gitea_db:/var/lib/postgresql/data
  mygitea-app:
    container_name: mygitea-app
    image: ${MY_DOCKER_IMAGE}
    depends_on:
      - mygitea-db
    environment:
      - RUN_CROND=true
    links:
      - mygitea-db:postgres
    ports:
      - 127.0.0.1:3022:22
      - 127.0.0.1:3000:3000
    restart: always
    volumes:
      - gitea_data:/data

volumes:
  gitea_db:
  gitea_data:
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
