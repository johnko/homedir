FROM ubuntu:24.04

RUN apt update ;\
  apt install -y cron curl

COPY crontab /etc/crontab

COPY entrypoint.sh /entrypoint.sh

COPY update-dns.sh /update-dns.sh

RUN chmod +x /entrypoint.sh /update-dns.sh
