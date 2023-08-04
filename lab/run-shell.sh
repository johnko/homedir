#!/bin/bash
set -eux

sed -i '' 's/127.0.0.1/labcluster/' ./tmp/k3s.yaml

IMAGE_NAME="shell:local"
docker build --platform linux/amd64 -t $IMAGE_NAME ./shell

docker run -it --rm --platform linux/amd64 -v ./tmp/k3s.yaml:/root/.kube/config $IMAGE_NAME
