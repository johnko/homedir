#!/usr/bin/env bash
set -euo pipefail

set -x

defaults -currentHost write com.apple.controlcenter.plist AirplayReceiverEnabled -bool false

defaults -currentHost read  com.apple.controlcenter.plist AirplayReceiverEnabled
