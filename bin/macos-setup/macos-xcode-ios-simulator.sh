#!/usr/bin/env bash
set -euo pipefail

if type xcodebuild &>/dev/null; then
  set -x

  xcodebuild -showsdks

  xcodebuild -runFirstLaunch

  xcodebuild -downloadPlatform iOS

  xcrun simctl runtime list

  xcrun simctl list

  xcrun simctl help
else
  echo "ERROR: missing 'xcodebuild'"
  exit 1
fi
