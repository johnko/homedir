#!/usr/bin/env bash
set -e
set -x
set -u

for id in $(tmutil destinationinfo | grep "^ID" | awk '{print $3}'); do
  tmutil startbackup --auto --block --rotation --destination $id
done

