#!/bin/bash
set -e

EXCLUDE_PATHS="
.aws
.devops-tools
.DS_Store
.git
agent.sock
creator-micro
iso
keychron
lab
lab-squid-ramdisk
nuphy
old
ollama-caddy
Preferences
squid
squid-demo-client
test-secrets-template.yaml
terminal-kctxt-qa-k9s.scpt
NOEXISTSEPERATOR
.Brewfile
.gitmodules
agent.toml
config
known_hosts
"

EXCLUDE_ARG=""
for i in $EXCLUDE_PATHS; do
  EXCLUDE_ARG="$EXCLUDE_ARG --exclude $i"
done

diff -r \
  $EXCLUDE_ARG \
  $1 $2
