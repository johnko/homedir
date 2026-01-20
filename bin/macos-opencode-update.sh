#!/usr/bin/env bash
set -euo pipefail

set -x

# renovate: datasource=github-releases depName=nodejs/node packageName=nodejs/node
NODE_VERSION=v24.12.0
# renovate: datasource=github-releases depName=anomalyco/opencode packageName=anomalyco/opencode
OPENCODE_VERSION=v1.1.16
# renovate: datasource=github-releases depName=devcontainers/cli packageName=devcontainers/cli
DEVCONTAINERS_VERSION=v0.80.3

if type mise &>/dev/null; then
  ## install opencode globally in mise environment
  mise exec node@$NODE_VERSION -- npm install --global opencode-ai@$OPENCODE_VERSION
  mise exec node@$NODE_VERSION -- npm install --global @devcontainers/cli@$DEVCONTAINERS_VERSION
else
  echo "ERROR: missing 'mise'"
  exit 1
fi
