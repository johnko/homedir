#!/bin/sh
# https://dradisframework.com/support/guides/customization/auto-unlock-luks-encrypted-drive.html
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -eux

KEYFILE=/boot/keyfile
CRYPT_DEV=/dev/mapper/dm_crypt-0
CRYPT_DEV_SHORT=${CRYPT_DEV##*/}
if [ ! -e $KEYFILE ]; then
  dd if=/dev/urandom of=$KEYFILE bs=1024 count=4
  chmod 0400 $KEYFILE
fi
if cryptsetup status $CRYPT_DEV | grep -q LUKS ; then
  TARGET_DEV=$(cryptsetup status $CRYPT_DEV | grep 'device:' | awk '{print $2}')
  cryptsetup -v luksAddKey $TARGET_DEV $KEYFILE
fi

BOOT_DEV=$(mount | grep '/boot ' | cut -d' ' -f1)
BOOT_DEV_SHORT=${BOOT_DEV##*/}
BOOT_DEV_UUID=$(blkid $BOOT_DEV | tr ' ' "\n" | grep ^UUID | tr -d '"' | cut -d= -f2)
if [ ! -e /etc/crypttab.bkp ]; then
  cp -a /etc/crypttab /etc/crypttab.bkp
fi
TARGET_DEV_UUID=$(cat /etc/crypttab.bkp | cut -d' ' -f2)

cat >/etc/crypttab <<EOF
$(cat /etc/crypttab.bkp | grep -v $CRYPT_DEV_SHORT)
$CRYPT_DEV_SHORT $TARGET_DEV_UUID /dev/disk/by-uuid/$BOOT_DEV_UUID:/keyfile luks,keyscript=/lib/cryptsetup/scripts/passdev
EOF

KERNEL_RELEASE=$(uname --kernel-release)
mkinitramfs -o /boot/initrd.img $KERNEL_RELEASE
