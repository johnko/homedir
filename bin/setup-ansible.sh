#!/usr/bin/env bash
set -e
set -x
set -u

if which apt-get; then
    export DEBIAN_FRONTEND=noninteractive
    # Dependency for virtualenv
    sudo apt-get install --yes build-essential python-dev libffi-dev
    which virtualenv || sudo apt-get install --yes python-virtualenv
    # Dependency for ansible
    sudo apt-get install --yes libssl-dev
fi

if ! which virtualenv; then
    if which pip2; then
        pip2 install virtualenv
    fi
fi

if ! which virtualenv; then
    if which pip; then
        pip install virtualenv
    fi
fi

if ! which virtualenv; then
    if which easy_install; then
        sudo easy_install virtualenv
    fi
fi

# Install ansible in a virtualenv
VENV_FOLDER="venv"
virtualenv ${VENV_FOLDER}
. ${VENV_FOLDER}/bin/activate
pip2 install --upgrade pip
pip2 install --upgrade ansible

# Instructions to user
set +x
echo "======================================"
echo "Ansible setup complete!"
echo "Now you can:"
echo "    source ${VENV_FOLDER}/bin/activate"
echo "    ansible-playbook ..."
