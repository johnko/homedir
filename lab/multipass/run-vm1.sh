#!/bin/bash
set -eu
set +x
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

IMAGE=22.04
NIC=en2
NAME=vm1

multipass set local.driver=qemu

case $1 in
  destroy)
    multipass stop $NAME
    multipass delete $NAME
    multipass purge
    ;;
  down)
    multipass stop $NAME
    ;;
  ps)
    multipass info $NAME
    ;;
  restart)
    launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist
    launchctl load -w /Library/LaunchDaemons/com.canonical.multipassd.plist
    ;;
  up | *)
    multipass start $NAME \
    || multipass launch \
      -vvv \
      --name=$NAME \
      --cpus=4 \
      --memory=16G \
      --disk=250G \
      --network="name=$NIC,mode=auto" \
      --cloud-init=./cloud-init.yaml \
      $IMAGE
    ;;
esac
