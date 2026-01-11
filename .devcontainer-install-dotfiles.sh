#!/bin/bash
set -euxo pipefail

if devcontainer-info > /dev/null 2>&1; then
  rsync -iaP --exclude-from=${HOME}/dotfiles/.rsync_exclude "$HOME/dotfiles/" "$HOME/"
fi
