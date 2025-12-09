#!/usr/bin/env bash
set -euxo pipefail

apt update -y

apt install -y \
  locales \
  openssh-server \
  moreutils

locale-gen en_US.UTF-8

mkdir /run/sshd

install -d -m 500 /root/.ssh
chmod 400 /root/.ssh/authorized_keys

NEW_USERNAME=jumpbox

useradd --create-home --shell /bin/bash --home-dir /home/$NEW_USERNAME $NEW_USERNAME
# unlock new user but invalid password
usermod -p '*' $NEW_USERNAME
install -d -m 500 -o $NEW_USERNAME -g $NEW_USERNAME /home/$NEW_USERNAME/.ssh
install -m 400 -o $NEW_USERNAME -g $NEW_USERNAME /root/.ssh/authorized_keys /home/$NEW_USERNAME/.ssh/authorized_keys
