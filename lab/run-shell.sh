#!/bin/bash
set -e
set +x
if [ "x" = "x$LABCLUSTER_IP" ]; then
  echo "ERROR: Missing export LABCLUSTER_IP=..."
  exit 1
fi
set -ux

IMAGE_NAME="shell:local"

sed -i '' 's,server: https://192.168.64.11:16443,server: https://labcluster:16443,' ./tmp/kubeconfig.yaml

cp ./argocd/run-argocd.sh ./shell/
docker build \
  --platform linux/amd64 \
  -t $IMAGE_NAME ./shell

docker run -it --rm \
  --platform linux/amd64 \
  -v ./tmp/kubeconfig.yaml:/root/.kube/config \
  --add-host labcluster:$LABCLUSTER_IP \
  $IMAGE_NAME
