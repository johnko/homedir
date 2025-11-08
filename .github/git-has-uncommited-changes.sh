#!/usr/bin/env bash
set -euxo pipefail

git version

FILE_CHANGED_COUNT=$(git status -s | wc -l | awk '{print $1}')
if [[ $FILE_CHANGED_COUNT -gt 0 ]]; then
  exit 1
fi
