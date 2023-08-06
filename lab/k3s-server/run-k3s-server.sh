#!/bin/bash
set -eu
set +x
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

case $1 in
  build)
    docker-compose build
    ;;
  cert)
    cp -a /etc/ssl/pgsql-server.pem ./pgsql-server.pem
    ;;
  destroy)
    ## Destroy the stack and data
    docker-compose down --volumes
    ;;
  down)
    ## Destroy the stack but keep the data
    docker-compose down
    ;;
  logs)
    docker-compose logs
    ;;
  ps)
    docker-compose ps
    ;;
  pull)
    docker-compose pull
    ;;
  test-new)
    bash $0 destroy
    bash $0 up
    ;;
  top)
    docker-compose top
    ;;
  up | *)
    bash $0 cert
    bash $0 build
    ## Create and run the stack interactively
    # docker-compose up
    ## Create and run the stack in the background
    docker-compose up --detach
    ;;
esac
