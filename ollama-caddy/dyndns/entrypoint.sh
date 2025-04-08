#!/usr/bin/env bash

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

echo >/var/log/my.log

tail -f /var/log/my.log &

cron -f &> /var/log/my.log
