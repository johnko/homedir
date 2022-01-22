#!/usr/bin/env bash
set -euo pipefail

if [            -e "$HOME/Library/Python/3.8/bin" ]; then
  export PATH=$PATH:$HOME/Library/Python/3.8/bin
fi

# Debian / Ubuntu
if command -v apt-get >/dev/null 2>&1 ; then
  echo "=>  Detected apt-get..."
  export DEBIAN_FRONTEND=noninteractive
  # Dependency for virtualenv
  sudo apt-get install --yes build-essential python-dev libffi-dev
  which virtualenv || sudo apt-get install --yes python-virtualenv
  # Dependency for ansible
  sudo apt-get install --yes libssl-dev
fi

echo "=>  Detecting pip3, pip2 or pip..."
# Last one wins
command -v pip  >/dev/null 2>&1 && PIP_BIN="pip"
command -v pip3 >/dev/null 2>&1 && PIP_BIN="pip3"
# Last one wins
command -v python    >/dev/null 2>&1 && PY_BIN="python"
command -v python3   >/dev/null 2>&1 && PY_BIN="python3"
command -v python3.7 >/dev/null 2>&1 && PY_BIN="python3.7"

echo "=>  Installing virtualenv..."
if ! command -v virtualenv >/dev/null 2>&1 ; then
  if [ -n "${PIP_BIN}" ] ; then
    ${PIP_BIN} config set global.index-url https://pypi.org/simple 2>&1 | awk '{print "    "$0}'
    ${PIP_BIN} config list 2>&1 | awk '{print "    "$0}'
    ${PIP_BIN} install virtualenv 2>&1 | awk '{print "    "$0}'
  fi
fi
if ! command -v virtualenv >/dev/null 2>&1 ; then
  command -v easy_install >/dev/null 2>&1 && \
    easy_install virtualenv 2>&1 | awk '{print "    "$0}'
fi
if ! command -v virtualenv >/dev/null 2>&1 ; then
  echo "!!  Failed to install virtualenv"
  exit 1
fi

# Install dev tools in a virtualenv
VENV_FOLDER="virtualenv-py3"
virtualenv "${VENV_FOLDER}" | awk '{print "    "$0}'
source "${VENV_FOLDER}/bin/activate"

echo "=>  Installing latest pip..."
curl -s https://bootstrap.pypa.io/get-pip.py | ${PY_BIN} 2>&1 | awk '{print "    "$0}'

echo "=>  Installing python development tools..."
${PIP_BIN} install --upgrade \
  yamllint \
  yq \
  flake8 \
  nose \
  jinjalint \
  ansible \
2>&1 | awk '{print "    "$0}'
echo "=>  Installation complete!"

echo "    To activate, run:"
echo "        source ${VENV_FOLDER}/bin/activate"
echo "=>  Setup is complete!"
