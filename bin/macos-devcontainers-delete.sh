#!/usr/bin/env bash
set -euo pipefail

set -x

if [ -e "$HOME/Library/Application Support/Code/User/settings.json" ]; then

  docker ps -a | grep devcontainers | awk '{print $NF}' | xargs -t docker rm -f
  docker volume ls | grep vscode | awk '{print $NF}' | xargs -t docker volume rm

fi
