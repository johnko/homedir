#!/usr/bin/env bash
set -e
set -x
set -u

create_default_zpool() {
  ## See https://openzfsonosx.org/wiki/Zpool#Creating_a_pool
  sudo zpool create -f \
    -o ashift=12 \
    -O casesensitivity=insensitive -O normalization=formD \
    -O atime=off -O compression=lz4 \
    -O copies=2 \
    ${poolname} ${diskX}
  # mirror $diskX $diskY
  while sudo mdutil -i off /Volumes/${poolname} | grep 'Please try again in a moment'; do
    sleep 1
  done
  sudo zpool set feature@encryption=enabled ${poolname}
}

create_enc_filesystem() {
  sudo zfs create \
    -o encryption=on -o keylocation=prompt -o keyformat=passphrase \
    -o casesensitivity=sensitive \
    -o normalization=formD \
    ${poolname}/enc
  while sudo mdutil -i off /Volumes/${poolname}/enc | grep 'Please try again in a moment'; do
    sleep 1
  done
}

create_data_filesystem() {
  sudo zfs create \
    -o casesensitivity=sensitive \
    -o normalization=formD \
    ${poolname}/data
  while sudo mdutil -i off /Volumes/${poolname}/data | grep 'Please try again in a moment'; do
    sleep 1
  done
}

create_default_zpool
create_enc_filesystem
create_data_filesystem
