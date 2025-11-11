#!/usr/bin/env bash
set -euo pipefail

DEVICE_NAME='my-iphone16'
DEVICE_TYPE='iPhone 16 Pro'
EXCLUDE_DEVICE_TYPE='Max'

if type xcrun &>/dev/null; then
  set +u
  ID=$(xcrun simctl list devices | grep "$DEVICE_NAME" | awk '{print $2}' | tr -d '()')
  if [[ -z $ID ]]; then
    set -u
    SIM_DEVICE_TYPE=$(xcrun simctl list devicetypes | grep "$DEVICE_TYPE" | grep -v "$EXCLUDE_DEVICE_TYPE" | grep -o '(.*)' | tr -d '()')

    SIM_RUNTIME_ID=$(xcrun simctl list runtimes | grep -o ' - [^ ]*$' | sed 's, - ,,')

    xcrun simctl create $DEVICE_NAME $SIM_DEVICE_TYPE $SIM_RUNTIME_ID

    ID=$(xcrun simctl list devices | grep "$DEVICE_NAME")
  fi

  echo "My devices:"
  echo $ID

  xcrun simctl shutdown $ID || true

  xcrun simctl erase $ID

  xcrun simctl boot $ID

  open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app
else
  echo "ERROR: missing 'xcrun'"
  exit 1
fi
