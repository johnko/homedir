#!/usr/bin/env bash
set -euo pipefail

set -x

cd ~/

for i in \
  Library/Preferences/com.apple.symbolichotkeys.plist \
  Library/Containers/com.apple.Desktop-Settings.extension/Data/Library/Preferences/com.apple.symbolichotkeys.plist; do

  # not sure if needed anymore in macOS Tahoe ~/Library/Containers/com.apple.Desktop-Settings.extension

  # BACKUP TO JSON (sorted)
  if [[ -e $i ]]; then
    plutil -convert json -o ./tmp_symbolichotkeys.json $i
    cat ./tmp_symbolichotkeys.json | jq '.AppleSymbolicHotKeys' --sort-keys >${i}.json
    rm ./tmp_symbolichotkeys.json
  fi

  # READ
  # plutil -p $i

  # WRITE
  #   plutil -replace AppleSymbolicHotKeys -json '
  # {
  #   "118": {
  #     "enabled": false,
  #     "value": {
  #       "parameters": [
  #         65535,
  #         18,
  #         262144
  #       ],
  #       "type": "standard"
  #     }
  #   }' $i
done
