#!/usr/bin/env bash
set -euxo pipefail

# run ssh daemon in foreground with timestamp logging
/usr/sbin/sshd -D -e 2>&1 | /usr/bin/ts '[%FT%TZ]'
