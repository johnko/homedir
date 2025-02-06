#!/usr/bin/env bash
set -euo pipefail

export OLLAMA_HOST=127.0.0.1:11434
# export OLLAMA_HOST=`get-ip`:11434
# export OLLAMA_HOST=0.0.0.0:11434

if type ollama &>/dev/null ; then
  ollama serve
else
  echo "ERROR: missing 'ollama'"
  exit 1
fi
