FROM alpine:3.20

LABEL maintainer="nickgrealy@gmail.com"

#set enviromental values for certificate CA generation
ENV CN=squid.local \
    O=squid \
    OU=squid \
    C=US

#set proxies for alpine apk package manager
ARG all_proxy 

ENV http_proxy=$all_proxy \
    https_proxy=$all_proxy

# RUN apk add --no-cache \
#     squid openssl ca-certificates update-ca-certificates

RUN set -xe \
    && apk add --no-cache --no-progress alpine-conf tzdata openssl ca-certificates \
    && apk add --no-cache --no-progress --purge -uU --repository http://dl-cdn.alpinelinux.org/alpine/edge/main squid \
    && update-ca-certificates \
    && rm -rf /var/cache/apk/* /tmp/*

COPY start.sh /usr/local/bin/
COPY openssl.cnf.add /etc/ssl

RUN cat /etc/ssl/openssl.cnf.add >> /etc/ssl/openssl.cnf

RUN chmod +x /usr/local/bin/start.sh

EXPOSE 3128
EXPOSE 4128

ENTRYPOINT ["/usr/local/bin/start.sh"]