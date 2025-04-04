#!/usr/bin/env bash
set -eo pipefail

# last one wins
case $1 in
  public)
    export OLLAMA_HOST=0.0.0.0:11434
    ;;
  lan)
    export OLLAMA_HOST=`get-ip | head -n1`:11434
    ;;
  *)
    export OLLAMA_HOST=127.0.0.1:11434
    ;;
esac
echo "OLLAMA_HOST=$OLLAMA_HOST"

set -u

if type ollama &>/dev/null ; then
  ollama serve
else
  echo "ERROR: missing 'ollama'"
  exit 1
fi
