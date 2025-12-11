#!/usr/bin/env bash
set -euxo pipefail

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# run cron in foreground with timestamp logging
cron -f 2>&1 | /usr/bin/ts '[%FT%TZ]'
