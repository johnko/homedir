#!/bin/bash
set -eu
set +x
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

IMAGE=24.04
NIC=en1
NAME=vm3

set +u
case $1 in
  destroy)
    set +e
    while multipass list | grep $NAME; do
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
    # shellcheck disable=SC2009
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
    ls -l /Volumes/RAMDisk
    if test -h /var/root/Library/Application\ Support/multipassd; then
      ls -l /var/root/Library/Application\ Support/multipassd
    elif test -d /var/root/Library/Application\ Support/multipassd; then
      launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist
      install -d -v -g wheel -m 755 -o root /Volumes/RAMDisk/vm
      mv /var/root/Library/Application\ Support/multipassd /Volumes/RAMDisk/vm/multipassd
      ln -s /Volumes/RAMDisk/vm/multipassd /var/root/Library/Application\ Support/multipassd
      launchctl load -w /Library/LaunchDaemons/com.canonical.multipassd.plist
    else
      launchctl unload /Library/LaunchDaemons/com.canonical.multipassd.plist
      install -d -v -g wheel -m 755 -o root /Volumes/RAMDisk/vm/multipassd
      ln -s /Volumes/RAMDisk/vm/multipassd /var/root/Library/Application\ Support/multipassd
      launchctl load -w /Library/LaunchDaemons/com.canonical.multipassd.plist
    fi
    multipass get local.driver | grep qemu || multipass set local.driver=qemu
    multipass start $NAME ||
      multipass launch \
        -vvv \
        --name=$NAME \
        --cpus=4 \
        --memory=8G \
        --disk=10G \
        --network="name=$NIC,mode=auto" \
        --cloud-init=./cloud-init.yaml \
        $IMAGE
    ;;
esac
