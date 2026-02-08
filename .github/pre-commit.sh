#!/usr/bin/env bash
set -euxo pipefail

ANY_ERROR=false

set +e

if type tofu &>/dev/null; then
  bash -ex .github/opentofu-fmt.sh
  # shellcheck disable=SC2181
  [[ $? -ne 0 ]] && ANY_ERROR=true
  bash -ex .github/opentofu-validate.sh
  # shellcheck disable=SC2181
  [[ $? -ne 0 ]] && ANY_ERROR=true
fi

if type terraform &>/dev/null; then
  bash -ex .github/terraform-fmt.sh
  # shellcheck disable=SC2181
  [[ $? -ne 0 ]] && ANY_ERROR=true
  bash -ex .github/terraform-validate.sh
  # shellcheck disable=SC2181
  [[ $? -ne 0 ]] && ANY_ERROR=true
fi

if type shellcheck &>/dev/null; then
  bash -ex .github/shellcheck.sh
  # shellcheck disable=SC2181
  [[ $? -ne 0 ]] && ANY_ERROR=true
fi

if type shfmt &>/dev/null; then
  bash -ex .github/shfmt.sh
  # shellcheck disable=SC2181
  [[ $? -ne 0 ]] && ANY_ERROR=true
fi

set -e

if [[ "true" == "$ANY_ERROR" ]]; then
  exit 1
fi
