#!/usr/bin/env bash
set -e
set -x
set -u

# Mac OS Extended (Case-sensitive, Journaled, Encrypted)

for id in $(tmutil destinationinfo | grep "^ID" | awk '{print $3}'); do
  #tmutil startbackup --auto --block --rotation --destination $id
  tmutil startbackup --block --rotation --destination $id
done

