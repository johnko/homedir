#!/usr/bin/env bash
set -eux

# 1 GB = 2097152
# 2 GB = 4194304
diskutil erasevolume HFS+ "RAMDisk" `hdiutil attach -nomount ram://$(($1 * 2097152))`
