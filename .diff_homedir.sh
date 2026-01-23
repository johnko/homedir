#!/bin/bash
set -e

EXCLUDE_PATHS="
SAFETOIGNORE
.devops-tools
.DS_Store
.git
.gitmodules
agent.sock
agent.toml
allow-assume*
CODEOWNERS
creator-micro
devcontainer
gitea
gitlab-ce
iso
jenkins-lts
keychron
known_hosts
lab-squid-ramdisk
lulu
macos-lulu-rules-permafy.py
macos-lulu-rules-prettify.sh
macos-opencode-update.sh
nuphy
old
ollama-caddy
opencode
Preferences
renovate.json
squid
squid-demo-client
terminal-kctxt-qa-k9s.scpt
test-secrets-template.yaml
EXPECTEDDIFFSEPERATOR
.aws
${3}.Brewfile
${3}.gitconfig
.gitignore
${3}.osascripts
${3}.skhdrc
*.code-workspace
config.example
${3}settings.json
${3}tasks.json
"

EXCLUDE_ARG=""
for i in $EXCLUDE_PATHS; do
  EXCLUDE_ARG="$EXCLUDE_ARG --exclude $i"
done

# shellcheck disable=SC2086
diff -r \
  $EXCLUDE_ARG \
  "$1" "$2"
