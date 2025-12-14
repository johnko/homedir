#!/usr/bin/env bash
set -euo pipefail

DEVICE_NAME='my-android15'
ANDROID_API_VERSION='android-35'
ANDROID_ARCH='arm64'
EXCLUDE_DEVICE_TYPE='ext14|ps16k|tablet'

if [[ -e /opt/homebrew/opt/openjdk/libexec/openjdk.jdk ]]; then
  if [[ ! -e /Library/Java/JavaVirtualMachines/openjdk.jdk ]]; then
    sudo ln -sfn /opt/homebrew/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
  fi
fi

if type sdkmanager &>/dev/null; then
  ANDROID_PACKAGE=$(sdkmanager --list 2>&1 | grep 'system-images' | grep 'playstore' | grep "$ANDROID_API_VERSION" | grep "$ANDROID_ARCH" | grep -v -E "$EXCLUDE_DEVICE_TYPE" | awk '{print $1}' | sort -u)

  set -x

  sdkmanager --install "$ANDROID_PACKAGE"

  echo "no" | avdmanager --verbose create avd --force --name "$DEVICE_NAME" --package "$ANDROID_PACKAGE" --tag "google_apis_playstore" --abi "arm64-v8a"

  export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
  # export ANDROID_SDK_ROOT="/opt/homebrew/share/android-commandlinetools"
  if [[ ! -e "${ANDROID_SDK_ROOT}/system-images" ]]; then
    SRC=$(find /opt/homebrew/share/android-commandlinetools -type d -name system-images | sort -u | tail -n 1)
    ln -sfn "$SRC" "${ANDROID_SDK_ROOT}/system-images"
  fi

  emulator "@$DEVICE_NAME"
else
  echo "ERROR: missing 'sdkmanager'"
  exit 1
fi
