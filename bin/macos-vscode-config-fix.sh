#!/usr/bin/env bash
set -euo pipefail

set -x

sed -i '' "s,/Users/$USER/,~/,g" "Library/Application Support/Code/User/settings.json"
