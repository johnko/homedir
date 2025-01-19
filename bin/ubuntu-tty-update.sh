#!/usr/bin/env bash
set -eux

# https://serverfault.com/questions/209599/how-to-setup-etc-issues-to-show-the-ip-address-for-eth0

# don't run in macOS
if [[ ! -e /Users ]] && whoami | grep "root" ; then
  if [[ ! -f /etc/.issue.orig ]] ; then
    cp /etc/issue /etc/.issue.orig
  fi
  int=$( ls /sys/class/net | grep "enp" | head -1 )
  sed -r "s/^Ubuntu/\\\4\{$int\} - Ubuntu/" < /etc/.issue.orig > /etc/issue
  systemctl restart getty@tty1
fi
