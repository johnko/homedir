#!/usr/bin/env bash
set -eux

# between 1 to 128 inclusive
defaults write com.apple.dock tilesize -integer 64

killall Dock
