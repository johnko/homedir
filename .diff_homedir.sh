#!/bin/bash
set -e

EXCLUDE_PATHS="
SAFETOIGNORE
.devops-tools
.DS_Store
.git
agent.sock
agent.toml
CODEOWNERS
creator-micro
gitea
gitlab-ce
iso
jenkins-lts
keychron
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
EXPECTEDDIFFSEPERATOR
.aws
.Brewfile
.gitmodules
config.example
known_hosts
.gitconfig
.gitignore
"

EXCLUDE_ARG=""
for i in $EXCLUDE_PATHS; do
  EXCLUDE_ARG="$EXCLUDE_ARG --exclude $i"
done

# shellcheck disable=SC2086
diff -r \
  $EXCLUDE_ARG \
  "$1" "$2"
