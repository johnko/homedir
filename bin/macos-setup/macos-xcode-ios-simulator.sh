#!/usr/bin/env bash
set -euo pipefail

set -x

if type xcodebuild &>/dev/null ; then
  xcodebuild -showsdks

  xcodebuild -runFirstLaunch

  xcodebuild -downloadPlatform iOS
else
  echo "ERROR: missing 'xcodebuild'"
  exit 1
fi
