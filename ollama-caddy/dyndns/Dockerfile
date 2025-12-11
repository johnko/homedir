FROM ubuntu:24.04

RUN apt update -y ; \
  apt install -y \
    cron \
    curl \
    moreutils

COPY crontab /etc/crontab

COPY entrypoint.sh /entrypoint.sh

COPY update-dns.sh /update-dns.sh

COPY cron-exec-wrapper.sh /cron-exec-wrapper.sh

RUN chmod +x /entrypoint.sh /update-dns.sh /cron-exec-wrapper.sh
