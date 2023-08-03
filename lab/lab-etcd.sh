#!/usr/bin/env bash
set -eux

VERSION="v3.4.27"
NAME_0="etcd0"
NAME_1="etcd1"
NAME_2="etcd2"
IP_0="192.168.2.250"
IP_1="192.168.2.251"
IP_2="192.168.2.252"

if [ "$1" = "$NAME_0" ]; then
  NAME=$NAME_0
  IP=$IP_0
elif [ "$1" = "$NAME_1" ]; then
  NAME=$NAME_1
  IP=$IP_1
elif [ "$1" = "$NAME_2" ]; then
  NAME=$NAME_2
  IP=$IP_2
fi
docker run -it -v /usr/share/ca-certificates:/etc/ssl/certs -p $IP:4001:4001 -p $IP:2380:2380 -p $IP:2379:2379 \
  --name $NAME quay.io/coreos/etcd:$VERSION \
  /usr/local/bin/etcd \
  -name $NAME \
  -advertise-client-urls http://$IP:2379,http://$IP:4001 \
  -listen-client-urls http://0.0.0.0:2379,http://0.0.0.0:4001 \
  -initial-advertise-peer-urls http://$IP:2380 \
  -listen-peer-urls http://0.0.0.0:2380 \
  -initial-cluster-token my-etcd-cluster-token \
  -initial-cluster $NAME_0=http://$IP_0:2380,$NAME_1=http://$IP_1:2380,$NAME_2=http://$IP_2:2380 \
  -initial-cluster-state new
