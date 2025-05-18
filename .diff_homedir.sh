#!/bin/bash
set -e

EXCLUDE_PATHS="
.DS_Store
.git
.gitmodules
agent.sock
agent.toml
Containers
creator-micro
iso
keychron
lab
lab-squid-ramdisk
old
ollama-caddy
Preferences
squid
squid-demo-client
test-secrets-template.yaml
.aws
.devops-tools
NOEXISTSEPERATOR
.gitconfig
config
known_hosts
config.json
"

EXCLUDE_ARG=""
for i in $EXCLUDE_PATHS; do
  EXCLUDE_ARG="$EXCLUDE_ARG --exclude $i"
done

diff -r \
  $EXCLUDE_ARG \
  $1 $2
