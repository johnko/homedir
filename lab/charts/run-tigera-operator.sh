#!/bin/bash
set -eux

case $1 in
  list)
    helm list -n tigera-operator
    ;;
  pull)
    helm repo add argo https://argoproj.github.io/argo-helm
    ;;
  uninstall)
    helm uninstall -n tigera-operator calico
    ;;
  up | *)
    bash $0 pull
    pushd ./charts/tigera-operator
    helm upgrade --install --atomic --create-namespace -n tigera-operator  -f ../values.lab.yaml calico .
    popd
    ;;
esac
