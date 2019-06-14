#!/usr/bin/env bash
set -eux

MY_TMP_CONTEXT="${HOME}/docker-files/gitlab-ce"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

set +u
case ${1} in
open)
Gitlab:
  echo 'Manually disable sign-up http://gitlab.local/admin/application_settings'
  echo 'Manually disable gravatar http://gitlab.local/admin/application_settings'
  echo '127.0.0.1       gitlab.local    registry.local    pages.local    root.pages.local    mattermost.local' | sudo tee -a /etc/hosts
  open http://gitlab.local
  ;;
runner-register)
  docker-compose exec gitlab-runner update-ca-certificates
  docker-compose exec gitlab-runner gitlab-runner register
  ;;
runner-exec)
  docker-compose exec gitlab-runner bash
  ;;
exec)
  docker-compose exec gitlab-ce bash
  ;;
down)
  ## Destroy the stack but keep the data
  docker-compose down
  ;;
destroy)
  ## Destroy the stack and data
  docker-compose down --volumes
  ;;
logs)
  docker-compose logs
  ;;
ps)
  docker-compose ps
  ;;
top)
  docker-compose top
  ;;
up | *)
  if ! [ -e ./certificate.key ] && ! [ -e ./certificate.pem ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout ./certificate.key -out ./certificate.pem -config ./csr.conf -extensions 'v3_req'
    openssl x509 -in ./certificate.pem -noout -text
  fi
  docker-compose pull
  ## Create and run the stack interactively
  # docker-compose up
  ## Create and run the stack in the background
  docker-compose up -d
  ;;
esac

cd -
