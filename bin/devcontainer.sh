#!/usr/bin/env bash
set -euo pipefail

# renovate: datasource=github-releases depName=nodejs/node packageName=nodejs/node
NODE_VERSION=24.12.0

if type mise &>/dev/null; then
  ## run CLI
  mise exec node@$NODE_VERSION -- devcontainer "$@"
else
  echo "ERROR: missing 'mise'"
  exit 1
fi
