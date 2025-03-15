#!/usr/bin/env bash
set -euo pipefail

set -x

DEVICE_NAME='my-iphone16'
DEVICE_TYPE='iPhone 16 Pro'
EXCLUDE_DEVICE_TYPE='Max'

if type xcrun &>/dev/null ; then
  SIM_DEVICE_TYPE=$(xcrun simctl list devicetypes | grep $DEVICE_TYPE | grep -v $EXCLUDE_DEVICE_TYPE | grep -o '(.*)' | tr -d '()')

  SIM_RUNTIME_ID=$(xcrun simctl list runtimes | grep -o ' - [^ ]*$' | sed 's, - ,,')

  xcrun simctl create $DEVICE_NAME $SIM_DEVICE_TYPE $SIM_RUNTIME_ID
else
  echo "ERROR: missing 'xcrun'"
  exit 1
fi
