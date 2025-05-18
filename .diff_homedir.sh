#!/bin/bash
set -e

EXCLUDE_PATHS="
.aws
.devops-tools
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
NOEXISTSEPERATOR
.gitconfig
.gitignore
config
config.json
known_hosts
.Brewfile.custom
"

EXCLUDE_ARG=""
for i in $EXCLUDE_PATHS; do
  EXCLUDE_ARG="$EXCLUDE_ARG --exclude $i"
done

diff -r \
  $EXCLUDE_ARG \
  $1 $2
