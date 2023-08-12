#!/bin/bash
set -eux

case $1 in
  web | *)
    set +x
    echo Password: $(kubectl -n pihole get secret pihole-password -o jsonpath="{.data.password}" | base64 -d)
    echo
    set -x
    kubectl port-forward service/pihole-web -n pihole 8081:80 &
    open http://localhost:8081/admin/
    ;;
esac
