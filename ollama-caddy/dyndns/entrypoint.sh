#!/usr/bin/env bash
set -euxo pipefail

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
LOG_FILE=/var/log/my.log

echo >$LOG_FILE

tail -f $LOG_FILE &

cron -f &>>$LOG_FILE
