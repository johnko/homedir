#!/usr/bin/env bash
set -euxo pipefail

SCRIPT_DIR=$(dirname "$0")
pushd "$SCRIPT_DIR"

if [[ -e ./pre-commit.sh ]] && [[ -d ../.git/hooks ]]; then
  install -m 700 ./pre-commit.sh ../.git/hooks/pre-commit
fi
