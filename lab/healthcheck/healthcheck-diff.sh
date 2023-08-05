#!/bin/bash
set -eu

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

FILE="/var/tmp/healthcheck"
ACTION=$1
IP=$2

if [ "ping" = "$ACTION" ]; then
  echo "[healthcheck] starting ping..."
  ping -c 1 -W 10 $IP \
    && touch $FILE
else
  NOW=$(date "+%s")
  THEN=$(stat $FILE --format "%Y")
  # diff of now vs file modified time in seconds
  DIFF=$(( NOW - THEN ))
  # limit in seconds, eg. 600 = 10 minutes
  LIMIT=$2
  if [ $DIFF -gt $LIMIT ]; then
    if [ "netplan" = "$ACTION" ]; then
      echo "[healthcheck] starting netplan..."
      netplan apply
    elif [ "reboot" = "$ACTION" ]; then
      echo "[healthcheck] starting reboot..."
      reboot --force
    fi
  fi
fi
