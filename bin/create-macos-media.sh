#!/usr/bin/env bash
set -e
set +x
set -u

##########

VOLUMECOUNT=$(find /Volumes -maxdepth 1 -mindepth 1 -type d | wc -l)
if [ ${VOLUMECOUNT} -eq 1 ]; then
  TARGET=$(find /Volumes -maxdepth 1 -mindepth 1 -type d)
  echo "Found 1 Volume."
  echo "Selecting ${TARGET}"
else
  echo "Which Volume should we overwrite?"
  read TARGET
fi

sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume "${TARGET}"
