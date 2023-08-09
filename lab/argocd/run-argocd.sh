#!/bin/bash
set -eux

case $1 in
  uninstall)
    helm uninstall -n argocd argo-cd
    ;;
  list)
    helm list -n argocd
    ;;
  pull)
    helm repo add argo https://argoproj.github.io/argo-helm
    # fetch the tar.gz so you can stash it
    helm pull argo/argo-cd
    ;;
  up | *)
    bash $0 pull
    helm upgrade --install --atomic --create-namespace -n argocd argo-cd argo/argo-cd
    ;;
esac
