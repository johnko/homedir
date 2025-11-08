#!/bin/bash
set -ex

if git diff --name-only | grep lab/renovatebotwrapper; then

  cd ./lab/renovatebotwrapper

  helm repo add argo https://argoproj.github.io/argo-helm
  helm repo add coredns https://coredns.github.io/helm
  helm repo add istio https://istio-release.storage.googleapis.com/charts
  helm repo add jetstack https://charts.jetstack.io
  helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
  helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
  helm repo add openfaas https://openfaas.github.io/faas-netes/
  helm repo add traefik https://traefik.github.io/charts

  # to fetch versions that Chart.lock has defined
  helm dep build

  cd ./charts

  # clean chart sources since files could have been deleted upstream
  for i in $(find . -maxdepth 1 -name '*.tgz' -print0 | xargs -0 --max-procs=1 --verbose -I{} tar tf {} 2>/dev/null | cut -f1 -d/ | sort -u); do
    if [ -d ./"$i"/ ]; then
      rm -fr ./"$i"/
    fi
  done

  # extract chart sources
  find . -maxdepth 1 -name '*.tgz' -print0 | xargs -0 --max-procs=1 --verbose -I{} tar xvf {}

  rm -v ./*.tgz

fi
