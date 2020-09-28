FROM ubuntu:latest
RUN apt-get update && apt-get install -y ca-certificates curl && rm -rf /var/cache/apt/*
COPY ./gitlab-ce.pem /usr/local/share/ca-certificates/gitlab.local.crt
RUN update-ca-certificates
