#!/usr/bin/env bash
set -euo pipefail

if which podman >/dev/null 2>&1 ; then
  set -x
  podman machine init
  podman machine start
  # podman machine set --rootful
else
  echo "ERROR: missing 'podman'"
  exit 1
fi
