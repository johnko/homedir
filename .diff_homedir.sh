#!/bin/bash
set -e

EXCLUDE_PATHS="
.aws
.devops-tools
.DS_Store
.git
agent.sock
CODEOWNERS
creator-micro
gitea
gitlab-ce
iso
jenkins-lts
keychron
lab
lab-squid-ramdisk
nuphy
old
ollama-caddy
Preferences
renovate.json
squid
squid-demo-client
terminal-kctxt-qa-k9s.scpt
test-secrets-template.yaml
NOEXISTSEPERATOR
.Brewfile
.gitmodules
agent.toml
config.example
known_hosts
"

EXCLUDE_ARG=""
for i in $EXCLUDE_PATHS; do
  EXCLUDE_ARG="$EXCLUDE_ARG --exclude $i"
done

diff -r \
  $EXCLUDE_ARG \
  $1 $2
