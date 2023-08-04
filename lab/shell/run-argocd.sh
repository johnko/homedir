#!/bin/bash
set -eu
set +x
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
set -x

case $1 in
  uninstall)
    helm uninstall -n argocd argo-cd
    ;;
  list)
    helm list -n argocd
    ;;
  pull)
    helm repo add argo https://argoproj.github.io/argo-helm
    ;;
  up | *)
    bash $0 pull
    kubectl create ns argocd
    helm upgrade --install --atomic -n argocd argo-cd argo/argo-cd
    ;;
esac
