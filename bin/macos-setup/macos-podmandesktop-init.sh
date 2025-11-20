#!/usr/bin/env bash
set -euo pipefail

MAX_MEMORY=2

if type podman &>/dev/null; then
  if type sysctl &>/dev/null; then
    MEMORY_TOTAL=$(sysctl hw.memsize | awk '{print $NF}')
    if [[ $MEMORY_TOTAL -gt 33222111000 ]]; then
      # we have over 33 GB of RAM, bigger podman machine
      MAX_MEMORY=16
    elif [[ $MEMORY_TOTAL -gt 17222111000 ]]; then
      # we have over 17 GB of RAM, bigger podman machine
      MAX_MEMORY=8
    elif [[ $MEMORY_TOTAL -gt 8222111000 ]]; then
      # we have over 8 GB of RAM, bigger podman machine
      MAX_MEMORY=4
    fi
  fi
  set -x
  podman machine init --cpus 8 --disk-size 150 --memory $((1024 * MAX_MEMORY))
  # podman machine set --rootful
  podman machine start
else
  echo "ERROR: missing 'podman'"
  exit 1
fi

## to delete
# podman machine stop
# podman machine rm
