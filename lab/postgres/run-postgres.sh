#!/bin/bash
set -eu

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

case $1 in
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
    cert_generateselfsigned ./pgsql-server
    docker-compose pull
    docker-compose up --detach
    ;;
  top)
    docker-compose top
    ;;
  up | *)
    cert_generateselfsigned ./pgsql-server
    docker-compose pull
    ## Create and run the stack interactively
    # docker-compose up
    ## Create and run the stack in the background
    docker-compose up --detach
    ;;
esac
