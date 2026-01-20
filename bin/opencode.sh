#!/usr/bin/env bash
set -euo pipefail

# renovate: datasource=github-releases depName=nodejs/node packageName=nodejs/node
NODE_VERSION=24.11.0

if type mise &>/dev/null; then
  ## run TUI/CLI
  mise exec node@$NODE_VERSION -- opencode "$@"
else
  echo "ERROR: missing 'mise'"
  exit 1
fi
