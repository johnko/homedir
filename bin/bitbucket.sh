#!/usr/bin/env bash
set -e
set -x
set -u

MY_TMP_CONTEXT="${HOME}/docker-files/bitbucket"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

set +u
case ${1} in
    open)
        open -a Firefox http://127.0.0.1:7990
        ;;
    stop)
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
    start|*)
        docker-compose pull
        ## Create and run the stack interactively
        # docker-compose up
        ## Create and run the stack in the background
        docker-compose up -d
        ;;
esac

cd -
