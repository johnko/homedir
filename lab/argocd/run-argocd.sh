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
    ;;
  up | *)
    bash $0 pull
    kubectl get ns argocd || kubectl create ns argocd
    helm upgrade --install --atomic -n argocd argo-cd argo/argo-cd
    ;;
esac
