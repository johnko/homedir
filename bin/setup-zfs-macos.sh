#!/usr/bin/env bash
set -e
set -x
set -u

create_default_zpool ()
{
    ## See https://openzfsonosx.org/wiki/Zpool#Creating_a_pool
    sudo zpool create -f \
        -o ashift=12 \
        -O casesensitivity=insensitive -O normalization=formD \
        -O atime=off -O compression=lz4 \
        -O copies=2 \
        ${poolname} ${diskX}
    # mirror $diskX $diskY
    sudo zpool set feature@encryption=enabled ${poolname}
}

create_data_filesystem ()
{
    sudo zfs create \
        -o encryption=on -o keylocation=prompt -o keyformat=passphrase \
        -o casesensitivity=sensitive \
        -o normalization=formD \
        ${poolname}/data
}

create_default_zpool
create_data_filesystem
