#!/usr/bin/env bash
set -euo pipefail

set -x

NODE_VERSION=24.11.0         # renovate: datasource=github-releases depName=nodejs/node packageName=nodejs/node
OPENCODE_VERSION=v8.17.0      # renovate: datasource=github-releases depName=anomalyco/opencode packageName=anomalyco/opencode
DEVCONTAINERS_VERSION=0.80.3 # renovate: datasource=github-releases depName=devcontainers/cli packageName=devcontainers/cli

if type mise &>/dev/null; then
  ## install opencode globally in mise environment
  mise exec node@$NODE_VERSION -- npm install --global opencode-ai@$OPENCODE_VERSION
  mise exec node@$NODE_VERSION -- npm install --global @devcontainers/cli@$DEVCONTAINERS_VERSION
else
  echo "ERROR: missing 'mise'"
  exit 1
fi
