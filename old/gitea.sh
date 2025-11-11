#!/usr/bin/env bash
set -eux

MY_TMP_CONTEXT="${HOME}/docker-files/gitea"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

generate_selfsigned_cert() {
  if ! [ -e ./pgsql-server.key ] && ! [ -e ./pgsql-server.pem ]; then
    openssl req -x509 -nodes -days 182 -newkey rsa:2048 -keyout ./pgsql-server.key -out ./pgsql-server.pem -config ./csr.conf -extensions 'v3_req'
    openssl x509 -in ./pgsql-server.pem -noout -text
  fi
}

set +u
case ${1} in
  open)
    open http://127.0.0.1:3000
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
  test-new)
    docker-compose down --volumes
    generate_selfsigned_cert
    docker-compose pull
    docker-compose up --detach
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
