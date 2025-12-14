#!/usr/bin/env bash
set -euo pipefail

set -x

if [[ ! -e /Volumes/RAMDisk/.metadata_never_index ]]; then
  set +x
  echo "=> Creating $1 GB /Volumes/RAMDisk..."
  set -x
  # 1 GB = 2097152
  # 2 GB = 4194304
  diskutil apfs create "$(hdiutil attach -nomount ram://$(($1 * 2097152)))" RAMDisk &&
    touch /Volumes/RAMDisk/.metadata_never_index
else
  set +x
  echo '=> /Volumes/RAMDisk Already exists!'
fi
