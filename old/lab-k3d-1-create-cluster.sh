#!/usr/bin/env bash
set -eux

# reference: https://k3d.io/v5.5.1/usage/multiserver/
# https://docs.k3s.io/datastore/ha-embedded

CURRENT_DIR=$(dirname $0)/tmp
mkdir -p $CURRENT_DIR
pushd $CURRENT_DIR

IMAGE=rancher/k3s:v1.26.4-k3s1
K3S_TOKEN="$1"
IP_ADDRESS="192.168.2.$2"
K3S_NODE_NAME="k3s-server-0"


K3S_CMD="docker run -d --restart=always --privileged=true -p $IP_ADDRESS:6443:6443 -p $IP_ADDRESS:2379:2379 -p $IP_ADDRESS:2380:2380 -v $CURRENT_DIR/$K3S_NODE_NAME-var:/var/lib/rancher/k3s/server -v $CURRENT_DIR/$K3S_NODE_NAME-etc:/etc/rancher/node --name $K3S_NODE_NAME -e K3S_TOKEN=$K3S_TOKEN -e K3S_NODE_NAME=$K3S_NODE_NAME $IMAGE server --tls-san=$IP_ADDRESS"

if ! docker inspect $K3S_NODE_NAME >/dev/null ; then
  $K3S_CMD --cluster-init

  sleep 30

  FOUND=0
  while [ "x0" = "x$FOUND" ]; do
    if docker logs $K3S_NODE_NAME 2>&1 | grep etc | grep -o -E '"initial-cluster":"[^"]*"' ; then
      FOUND=1
    fi
    sleep 5
  done

  ETCD_NAME=$(docker logs $K3S_NODE_NAME 2>&1 | grep etc | grep -o -E '"initial-cluster":"[^"]*"' | sed 's,":",=,' | cut -d= -f2)

  docker rm -f $K3S_NODE_NAME

  $K3S_CMD --cluster-init --etcd-arg="--name=$ETCD_NAME" --etcd-arg="--listen-peer-urls=https://0.0.0.0:2380" --etcd-arg="--listen-client-urls=https://0.0.0.0:2379" --etcd-arg="--initial-advertise-peer-urls=https://$IP_ADDRESS:2380" --etcd-arg="--advertise-client-urls=https://$IP_ADDRESS:2379" --datastore-endpoint="https://$IP_ADDRESS:2379"

  sleep 30
fi

docker cp $K3S_NODE_NAME:/etc/rancher/k3s/k3s.yaml ~/.kube/config
cat ~/.kube/config | sed "s,127.0.0.1,$IP_ADDRESS," > ~/.kube/configtmp
mv ~/.kube/configtmp ~/.kube/config
