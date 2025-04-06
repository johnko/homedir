#!/usr/bin/env bash
set -euo pipefail

set -x

sw_vers
softwareupdate --list
