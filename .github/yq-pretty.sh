#!/usr/bin/env bash
set -euxo pipefail

yq --version

find . -type f \( -name '*.yaml' -o -name '*.yml' \) -print0 | xargs -0 -P2 -I{} yq --exit-status --inplace --no-colors --prettyPrint 'sort_keys(..)' {}

bash -ex ./.github/git-has-uncommited-changes.sh
