#!/usr/bin/env bash
set -euo pipefail

for i in `seq 4`; do
  adb emu sensor set acceleration 20:9.81:0
  sleep 0.1
  adb emu sensor set acceleration -20:9.81:0
  sleep 0.1
  adb emu sensor set acceleration 0:9.81:0
done
