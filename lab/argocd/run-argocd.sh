#!/bin/bash
set -eux

case $1 in
  apps)
    pushd $(dirname $0)
    for i in app-*.yaml; do
      kubectl apply -f $i
    done
    popd
    ;;
  list)
    helm list -n argocd
    ;;
  pull)
    helm repo add argo https://argoproj.github.io/argo-helm
    ;;
  uninstall)
    helm uninstall -n argocd argo-cd
    ;;
  web)
    set +x
    echo Password: $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
    echo
    set -x
    kubectl port-forward service/argo-cd-argocd-server -n argocd 8080:443 &
    open http://localhost:8080
    ;;
  up | *)
    bash $0 pull
    helm upgrade --install --atomic --create-namespace -n argocd argo-cd argo/argo-cd
    ;;
esac
