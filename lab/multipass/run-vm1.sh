#!/bin/bash
set -eu
set +x
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

IMAGE=22.04
NIC=en2
NAME=vm1


case $1 in
  destroy)
    set +e
    while multipass list | grep $NAME ; do
      sleep 1
      multipass stop $NAME
      multipass delete $NAME
      multipass purge
    done
    ;;
  info)
    multipass info $NAME
    ;;
  ps)
    ps aux | grep qemu
    ;;
  restart)
    launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist
    launchctl load -w /Library/LaunchDaemons/com.canonical.multipassd.plist
    ;;
  stop)
    multipass stop $NAME
    ;;
  start | *)
    multipass get local.driver | grep qemu || multipass set local.driver=qemu
    multipass start $NAME \
    || multipass launch \
      -vvv \
      --name=$NAME \
      --cpus=4 \
      --memory=16G \
      --disk=50G \
      --network="name=$NIC,mode=auto" \
      --cloud-init=./cloud-init.yaml \
      $IMAGE
    ;;
esac
