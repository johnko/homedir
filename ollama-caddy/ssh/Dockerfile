FROM ubuntu:24.04

COPY authorized_keys /root/.ssh/authorized_keys

COPY _in_container_setup.sh /_in_container_setup.sh

RUN bash /_in_container_setup.sh

COPY sshd_config /etc/ssh/sshd_config

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
