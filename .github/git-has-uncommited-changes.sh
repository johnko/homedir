#!/usr/bin/env bash
set -euxo pipefail

git version

git diff --exit-code
