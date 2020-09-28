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
  echo "Jenkins > Configure Clouds"
  echo "==> Kubernetes URL:"
  echo "https://kind-local-control-plane:6443"
  echo "==> Kubernetes server certificate key"
  grep certificate-authority-data ${HOME}/.kube/config | awk '{print $NF}' | base64 -d >kind-ca.crt
  cat kind-ca.crt
  echo "==> Kubernetes Namespace:"
  echo "jenkinsagent"
  echo "==> Credentials:"
  grep client-certificate-data ${HOME}/.kube/config | awk '{print $NF}' | base64 -d >kind-client.crt
  grep client-key-data ${HOME}/.kube/config | awk '{print $NF}' | base64 -d >kind-client.key
  set -x
  openssl pkcs12 -export -out kind-cert.pfx -inkey kind-client.key -in kind-client.crt -certfile kind-ca.crt
  rm kind-client.key kind-client.crt kind-ca.crt
  set +x
  ls -l $(pwd)/kind-cert.pfx
  echo "==> Jenkins URL:"
  echo "http://jenkins-2.249.1:8080"
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
