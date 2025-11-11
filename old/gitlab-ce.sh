#!/usr/bin/env bash
set -eux

MY_TMP_CONTEXT="${HOME}/docker-files/gitlab-ce"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

generate_selfsigned_cert() {
  if ! [ -e ./gitlab-ce.key ] && ! [ -e ./gitlab-ce.pem ]; then
    openssl req -x509 -nodes -days 182 -newkey rsa:2048 -keyout ./gitlab-ce.key -out ./gitlab-ce.pem -config ./csr.conf -extensions 'v3_req'
    openssl x509 -in ./gitlab-ce.pem -noout -text
  fi
}

set +u
case ${1} in
  destroy)
    ## Destroy the stack and data
    docker-compose down --volumes
    ;;
  down)
    ## Destroy the stack but keep the data
    docker-compose down
    ;;
  exec)
    docker-compose exec gitlab-ce bash
    ;;
  logs)
    docker-compose logs
    ;;
  open)
    echo 'Manually disable sign-up https://gitlab.local/admin/application_settings'
    echo 'Manually disable gravatar https://gitlab.local/admin/application_settings'
    echo '127.0.0.1       gitlab.local    registry.local    mattermost.local    pages.local    root.pages.local' | sudo tee -a /etc/hosts
    open https://gitlab.local
    ;;
  ps)
    docker-compose ps
    ;;
  runner-exec)
    docker-compose exec gitlab-runner bash
    ;;
  runner-register)
    docker-compose exec gitlab-runner gitlab-runner register
    ;;
  test-new)
    docker-compose down --volumes
    generate_selfsigned_cert
    docker-compose pull
    docker-compose up --detach
    ;;
  test-ssl)
    docker-compose exec gitlab-runner curl -v https://gitlab.local/
    docker-compose exec gitlab-ce curl -v https://gitlab.local/
    docker build -f alpine.Dockerfile -t runner-alpine:latest .
    docker build -f ubuntu.Dockerfile -t runner-ubuntu:latest .
    docker run --rm --interactive --tty --network gitlab-ce_default runner-alpine:latest curl -v https://gitlab.local/
    docker run --rm --interactive --tty --network gitlab-ce_default runner-ubuntu:latest curl -v https://gitlab.local/
    ;;
  top)
    docker-compose top
    ;;
  up | *)
    generate_selfsigned_cert
    docker-compose pull
    ## Create and run the stack interactively
    # docker-compose up
    ## Create and run the stack in the background
    docker-compose up --detach
    ;;
esac

cd -
