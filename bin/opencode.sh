#!/usr/bin/env bash
set -euo pipefail

# renovate: datasource=github-releases depName=nodejs/node packageName=nodejs/node
NODE_VERSION=24.12.0

if uname | grep -i "darwin"; then
  echo "ERROR: detected running in macOS. Aborting."
  exit 1
fi

if type mise &>/dev/null; then
  ## run TUI/CLI
  mise exec node@$NODE_VERSION -- opencode "$@"
else
  echo "ERROR: missing 'mise'"
  exit 1
fi
