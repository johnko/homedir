#!/usr/bin/env bash
set -euxo pipefail

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# run the update script in foreground with timestamp logging
/bin/bash /update-dns.sh 2>&1 | /usr/bin/ts '[%FT%TZ]' >>/proc/1/fd/1
