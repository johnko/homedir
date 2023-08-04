#!/bin/bash
set -eux

IMAGE_NAME="shell:local"

sed -i '' 's/127.0.0.1/labcluster/' ./tmp/k3s.yaml

cp ./argocd/run-argocd.sh ./shell/
docker build \
  --platform linux/amd64 \
  -t $IMAGE_NAME ./shell

docker run -it --rm \
  --platform linux/amd64 \
  -v ./tmp/k3s.yaml:/root/.kube/config \
  --add-host labcluster:192.168.2.232 \
  $IMAGE_NAME
