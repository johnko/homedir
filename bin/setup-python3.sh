#!/usr/bin/env bash
set -euo pipefail

if [[ -e "$HOME/Library/Python/3.8/bin" ]]; then
  export PATH=$PATH:$HOME/Library/Python/3.8/bin
fi

# Debian / Ubuntu
if command -v apt-get >/dev/null 2>&1; then
  echo "=>  Detected apt-get..."
  export DEBIAN_FRONTEND=noninteractive
  # Dependency for virtualenv
  sudo apt-get install --yes build-essential python-dev libffi-dev
  type virtualenv &>/dev/null || sudo apt-get install --yes python-virtualenv
  # Dependency for ansible
  sudo apt-get install --yes libssl-dev
fi

echo "=>  Detecting python3, python2..."
# Last one wins
command -v python >/dev/null 2>&1 && PY_BIN="python"
command -v python3 >/dev/null 2>&1 && PY_BIN="python3"
command -v python3.7 >/dev/null 2>&1 && PY_BIN="python3.7"

VENV_FOLDER="venv-python3"
VENV_PATH="${HOME}/${VENV_FOLDER}"
${PY_BIN} -m venv "${VENV_PATH}"
# shellcheck disable=SC1091
source "${VENV_PATH}/bin/activate"

echo "=>  Detecting pip3, pip2 or pip..."
# Last one wins
command -v pip >/dev/null 2>&1 && PIP_BIN="pip"
command -v pip3 >/dev/null 2>&1 && PIP_BIN="pip3"

if ! type python | grep -q ${VENV_FOLDER}; then
  echo "!!  Failed to use venv"
  exit 1
fi

echo "=>  Listing python libraries..."

${PIP_BIN} list

echo "=>  Installing latest pip..."

${PIP_BIN} install --upgrade pip setuptools wheel

echo "=>  Installing python development tools..."
${PIP_BIN} install --upgrade \
  pygments \
  yamllint \
  flake8 \
  autopep8 \
  black \
  nose \
  ansible \
  2>&1 | awk '{print "    "$0}'
echo "=>  Installation complete!"

echo "    To activate, run:"
echo "        source ${VENV_PATH}/bin/activate"
echo "=>  Setup is complete!"
