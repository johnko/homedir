#!/usr/bin/env bash
set -euxo pipefail

yq --version

find . -type f \( -name '*.yaml' -o -name '*.yml' \) -not -path '*/lab/charts/*' -not -path '*/lab/traefik/*' -not -path '*/docker-files/squid/ref/*' -print0 | xargs -0 --max-procs=2 --verbose -I{} yq --exit-status --inplace --no-colors --prettyPrint 'sort_keys(..)' {}

bash -ex ./.github/git-has-uncommited-changes.sh
