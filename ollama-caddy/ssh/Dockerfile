FROM ubuntu:24.04

RUN apt update ;\
  apt install -y locales openssh-server ;\
  locale-gen en_US.UTF-8 ;\
  mkdir /run/sshd ;\
  install -d -m 500 /root/.ssh

COPY sshd_config /etc/ssh/sshd_config

COPY authorized_keys /root/.ssh/authorized_keys

RUN chmod 400 /root/.ssh/authorized_keys
