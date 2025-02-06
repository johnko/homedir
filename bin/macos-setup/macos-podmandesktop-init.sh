#!/usr/bin/env bash
set -euo pipefail

if type podman &>/dev/null ; then
  set -x
  podman machine init
  podman machine start
  # podman machine set --rootful
else
  echo "ERROR: missing 'podman'"
  exit 1
fi
