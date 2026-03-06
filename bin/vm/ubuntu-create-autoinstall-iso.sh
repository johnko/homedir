#!/usr/bin/env bash
set -eux

VENV_FOLDER="venv-python3"
SCRIPT_NAME="create-autoinstall-iso.sh"

rsync -virchlmP "${HOME}/bin/setup-python3.sh" vm:./setup-python3.sh
rsync -virchlmP "$(dirname "$0")/grub.cfg" vm:/tmp/grub.cfg
rsync -virchlmP "${HOME}/iso/arm/ubuntu-24.04.4-live-server-arm64.iso" vm:./ubuntu-24.04.4-live-server-arm64.iso
cat <<EOS >"$SCRIPT_NAME"
apt update
apt install -y git python3 python3-pip xorriso
rm -fr livefs-editor
git clone https://github.com/johnko/livefs-editor.git
bash ./setup-python3.sh
source /root/${VENV_FOLDER}/bin/activate
python3 -m pip install ./livefs-editor/
python3 -m livefs_edit ubuntu-24.04.4-live-server-arm64.iso autoinstall-24.04.2-live-server-arm64.iso --cp /tmp/grub.cfg new/iso/boot/grub/grub.cfg
EOS
rsync -virchlmP "${SCRIPT_NAME}" vm:"./${SCRIPT_NAME}"
rm "$SCRIPT_NAME"
ssh vm sudo bash -ex ${SCRIPT_NAME}
rsync -virchlmP vm:./autoinstall-24.04.2-live-server-arm64.iso "${HOME}/iso/arm/autoinstall-24.04.2-live-server-arm64.iso"
