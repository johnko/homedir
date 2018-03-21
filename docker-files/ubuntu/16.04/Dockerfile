FROM ubuntu:16.04
RUN which apt-get && apt-get update && apt-get upgrade --yes && apt-get install --yes git
RUN cp -a /root/.bashrc /root/.bashrc2
COPY .bashrc /root/.bashrc
