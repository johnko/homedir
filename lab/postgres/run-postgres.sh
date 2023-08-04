#!/bin/bash
set -eu
set +x
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

case $1 in
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
    docker-compose down --volumes
    cert_generateselfsigned ./pgsql-server
    chown 999:999 ./pgsql-server.key
    docker-compose pull
    docker-compose up --detach
    ;;
  top)
    docker-compose top
    ;;
  up | *)
    cert_generateselfsigned ./pgsql-server
    chown 999:999 ./pgsql-server.key
    docker-compose pull
    ## Create and run the stack interactively
    # docker-compose up
    ## Create and run the stack in the background
    docker-compose up --detach
    ;;
esac
