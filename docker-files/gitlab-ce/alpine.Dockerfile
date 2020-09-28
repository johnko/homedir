FROM alpine:latest
RUN apk update && apk add ca-certificates curl && rm -rf /var/cache/apk/*
COPY ./gitlab-ce.pem /usr/local/share/ca-certificates/gitlab.local.crt
RUN update-ca-certificates
