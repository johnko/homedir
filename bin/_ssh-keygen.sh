#!/usr/bin/env bash
set -eux

# OUTFILE="${HOME}/.ssh/id_rsanopass"
# if [ ! -f "${OUTFILE}" ]; then
#   ssh-keygen -b 4096 -t rsa -N '' -f "${OUTFILE}"
# fi

ssh-keygen -t ed25519 -C "$( whoami )@$( date +%y%m%dT%H%M%S )"
