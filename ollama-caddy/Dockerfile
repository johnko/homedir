FROM ubuntu:24.04

# https://github.com/golang/go/issues/65568
ENV GOTOOLCHAIN=local

RUN apt update -y ;\
  apt install -y gpg wget curl ;\
  install -dm 755 /etc/apt/keyrings ;\
  wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null ;\
  echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=arm64] https://mise.jdx.dev/deb stable main" | tee /etc/apt/sources.list.d/mise.list ;\
  apt update -y ;\
  apt install -y mise ;\
  apt install -y debian-keyring debian-archive-keyring apt-transport-https ;\
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/gpg.key' | gpg --dearmor -o /usr/share/keyrings/caddy-xcaddy-archive-keyring.gpg ;\
  curl -1sLf 'https://dl.cloudsmith.io/public/caddy/xcaddy/debian.deb.txt' | tee /etc/apt/sources.list.d/caddy-xcaddy.list ;\
  apt update -y ;\
  apt install -y xcaddy

RUN mise use -g go@1.25 ;\
  mise install ;\
  bash -c 'eval "$(mise activate bash)" ; xcaddy build'

RUN mv /caddy /usr/bin/caddy

COPY Caddyfile /etc/caddy/Caddyfile
