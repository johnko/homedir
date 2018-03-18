#!/usr/bin/env bash
set -e
set -x

# OUTFILE="${HOME}/.ssh/id_rsanopass"
# if [ ! -f "${OUTFILE}" ]; then
#   ssh-keygen -b 4096 -t rsa -N '' -f "${OUTFILE}"
# fi

ssh-keygen -b 4096 -t rsa
