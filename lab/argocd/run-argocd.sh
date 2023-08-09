#!/bin/bash
set -eux

case $1 in
  list)
    helm list -n argocd
    ;;
  pull)
    helm repo add argo https://argoproj.github.io/argo-helm
    # fetch the tar.gz so you can stash it
    helm pull argo/argo-cd
    ;;
  uninstall)
    helm uninstall -n argocd argo-cd
    ;;
  web)
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443 &
    open http://localhost:8080
    ;;
  up | *)
    bash $0 pull
    helm upgrade --install --atomic --create-namespace -n argocd argo-cd argo/argo-cd
    ;;
esac
