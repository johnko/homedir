FROM ubuntu:24.04

RUN apt update ;\
  apt install -y curl golang ;\
  apt install -y debian-keyring debian-archive-keyring apt-transport-https ;\
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-xcaddy-archive-keyring.gpg ;\
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-xcaddy.list ;\
  apt update ;\
  apt install -y xcaddy

RUN xcaddy build
RUN mv /caddy /usr/bin/caddy

COPY Caddyfile /etc/caddy/Caddyfile
