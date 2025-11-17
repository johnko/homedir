#!/usr/bin/env bash
set -exo pipefail

# when running in CI and terraform doesn't exist, install it
if [[ "true" == "$CI" ]]; then
  if ! type terraform &>/dev/null; then
    SUDO=''
    if type sudo &>/dev/null; then
      SUDO=sudo
    fi
    if type brew &>/dev/null; then
      brew tap hashicorp/tap
      brew install hashicorp/tap/terraform
    elif type snap &>/dev/null; then
      INSTALL_COMMAND="snap install terraform --classic"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    elif type apt &>/dev/null; then
      wget -O - https://apt.releases.hashicorp.com/gpg | $SUDO gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
      echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | $SUDO tee /etc/apt/sources.list.d/hashicorp.list
      $SUDO apt update
      INSTALL_COMMAND="apt install --yes terraform"
      # shellcheck disable=SC2086
      $INSTALL_COMMAND || $SUDO $INSTALL_COMMAND
    fi
  fi
else
  CI=false
fi
set -u

export IAC_BIN=terraform

$IAC_BIN version

for WORKSPACE in $(find . -name '*.tf' -not -path '*/.terraform/*' -not -path '*/docs/*/example/*' -print0 | xargs -0 -I{} dirname {} | sort -u); do
  bash -e .github/tf.sh "$WORKSPACE" validate
  if [[ "true" == "$CI" ]]; then
    # Git will refuse to modify untracked nested git repositories (directories with a .git subdirectory) unless a second -f is given.
    git clean -ffxd .
  fi
done
