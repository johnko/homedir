#!/usr/bin/env bash
set -eux

ssh vm sudo apt update
ssh vm sudo apt install -y git python3 python3-pip xorriso
ssh vm sudo rm -fr livefs-editor
ssh vm git clone https://github.com/mwhudson/livefs-editor
ssh vm sudo python3 -m pip install ./livefs-editor/
rsync -virchlmP $(dirname $0)/grub.cfg vm:/tmp/grub.cfg
rsync -virchlmP ${HOME}/iso/arm/ubuntu-22.04.5-live-server-arm64.iso vm:./ubuntu-22.04.5-live-server-arm64.iso
ssh vm sudo python3 -m livefs_edit ubuntu-22.04.5-live-server-arm64.iso autoinstall-22.04.5-live-server-arm64.iso --cp /tmp/grub.cfg new/iso/boot/grub/grub.cfg
rsync -virchlmP vm:./autoinstall-22.04.5-live-server-arm64.iso ${HOME}/iso/arm/autoinstall-22.04.5-live-server-arm64.iso
