#!/usr/bin/env bash
set -eux

MY_TMP_CONTEXT="${HOME}/docker-files/jenkins-lts"

[ ! -d ${MY_TMP_CONTEXT} ] && exit 1
cd ${MY_TMP_CONTEXT}

set +u
case ${1} in
open)
  open http://127.0.0.1:8080
  ;;
down)
  ## Destroy the stack but keep the data
  docker-compose down
  ;;
destroy)
  ## Destroy the stack and data
  docker-compose down --volumes
  ;;
logs)
  docker-compose logs
  ;;
ps)
  docker-compose ps
  ;;
top)
  docker-compose top
  ;;
k8sagents)
  set +x
  echo "==> Automation START"
  grep certificate-authority-data ${HOME}/.kube/config | awk '{print $NF}' | base64 -d >./kind-ca.crt

  kubectl apply -f ./k8s-ns.yaml

  if [ ! -e ./kind-client.pfx ]; then
    [ -e ./kind-client.key ] || openssl genrsa -out ./kind-client.key 4096
    if [ ! -e ./kind-client.csr ]; then
      openssl req -config ./csr.conf -new -key ./kind-client.key -nodes -out ./kind-client.csr
      export BASE64_CSR=$(cat ./kind-client.csr | base64 | tr -d '\n')
      cat ./k8s-csr.yaml | envsubst | kubectl apply -f -
      kubectl get csr jenkinsagent
      kubectl certificate approve jenkinsagent
    fi
    [ -e ./kind-client.crt ] || kubectl get csr jenkinsagent -o jsonpath='{.status.certificate}' | base64 --decode >./kind-client.crt
    [ -e ./kind-client.pfx ] || openssl pkcs12 -export -out ./kind-client.pfx -inkey ./kind-client.key -in ./kind-client.crt -certfile ./kind-ca.crt
  fi
  kubectl apply -f ./k8s-role.yaml
  kubectl apply -f ./k8s-rolebinding.yaml
  echo "==> Automation END"
  echo
  echo "==> Please open Jenkins > Manage Jenkins > Manage Nodes > Configure Clouds"
  echo
  echo "==> Kubernetes URL:"
  echo "https://kindlocal-control-plane:6443"
  echo
  echo "==> Kubernetes server certificate key"
  cat ./kind-ca.crt
  echo
  echo "==> Kubernetes Namespace:"
  echo "jenkinsagent"
  echo
  echo "==> Credentials:"
  ls -l $(pwd)/kind-client.pfx
  echo
  echo "==> Jenkins URL:"
  echo "http://jenkins-2.249.1:8080"
  echo
  echo "==> Pod Template > Name:"
  echo "root"
  echo
  echo "==> Pod Template > Run As User ID:"
  echo "0"
  echo
  echo "==> Pod Template > Run As Group ID:"
  echo "0"

  rm ./kind-client.key ./kind-client.crt ./kind-ca.crt ./kind-client.csr
  ;;
up | *)
  docker-compose pull
  ## Create and run the stack interactively
  # docker-compose up
  ## Create and run the stack in the background
  docker-compose up -d
  ;;
esac

cd -
