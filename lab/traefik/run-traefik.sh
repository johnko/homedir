#!/bin/bash
set -eux

case $1 in
  web | *)
    kubectl port-forward -n traefik $(kubectl get pods -n traefik --selector "app.kubernetes.io/name=traefik" --output=name | head -n1 ) 9588:9000 &
    open http://localhost:9588/dashboard/
    ;;
esac
