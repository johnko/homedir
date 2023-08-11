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
    # multipass stop $NAME
    # multipass delete $NAME
    # multipass purge
    sudo rm -fr "/Library/Application Support/multipassd/qemu"
    brew reinstall multipass
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
    multipass set local.driver=qemu
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
