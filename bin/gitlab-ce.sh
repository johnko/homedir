#!/usr/bin/env bash
set -e
set -x
set -u

## See more docs at https://docs.gitlab.com/omnibus/docker/README.html


MY_DOCKER_IMAGE=gitlab/gitlab-ce:10.5.4-ce.0
MY_TMP_CONTEXT="tmpcontext-gitlab-10.5"

[ ! -d ${MY_TMP_CONTEXT} ] && mkdir ${MY_TMP_CONTEXT}
cd ${MY_TMP_CONTEXT}
cat > docker-compose.yml <<EOF
version: "3.5"

services:
  mygitlab-app:
    container_name: mygitlab-app
    image: ${MY_DOCKER_IMAGE}
    hostname: '127.0.0.1:9090'
    environment:
      GITLAB_OMNIBUS_CONFIG: |
        external_url 'http://127.0.0.1:9090'
        gitlab_rails['gitlab_shell_ssh_port'] = 9022
    ports:
      - 127.0.0.1:9090:9090
      - 127.0.0.1:9022:22
    restart: always
    volumes:
      - gitlab_config:/etc/gitlab
      - gitlab_logs:/var/log/gitlab
      - gitlab_data:/var/opt/gitlab

volumes:
  gitlab_config:
  gitlab_data:
  gitlab_logs:
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
