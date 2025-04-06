#!/usr/bin/env bash
set -euo pipefail

set -x

defaults -currentHost write com.apple.controlcenter.plist AirplayReceiverEnabled -bool false

defaults -currentHost read  com.apple.controlcenter.plist AirplayReceiverEnabled

set +x

echo "You need to reboot for the setting to take effect."
