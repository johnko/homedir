# Helm Charts

```bash
helm dep update
```

## coredns

via https://github.com/coredns/helm

```bash
helm repo add coredns https://coredns.github.io/helm
helm pull coredns/coredns
rm -fr coredns
tar xvf coredns-*.tgz
SOURCE=$(ls -1 coredns-*.tgz)
rm coredns-*.tgz
git add coredns
git commit -m "track chart $SOURCE"
```

## metrics-server

via https://github.com/kubernetes-sigs/metrics-server/tree/master/charts/metrics-server

```bash
helm repo add metrics-server https://kubernetes-sigs.github.io/metrics-server/
helm pull metrics-server/metrics-server
rm -fr metrics-server
tar xvf metrics-server-*.tgz
SOURCE=$(ls -1 metrics-server-*.tgz)
rm metrics-server-*.tgz
git add metrics-server
git commit -m "track chart $SOURCE"
```

## argo-cd

via https://github.com/argoproj/argo-helm/

```bash
helm repo add argo https://argoproj.github.io/argo-helm
helm pull argo/argo-cd
rm -fr argco-cd
tar xvf argo-cd-*.tgz
SOURCE=$(ls -1 argo-cd-*.tgz)
rm argo-cd-*.tgz
git add argco-cd
git commit -m "track chart $SOURCE"
```

## traefik

via https://github.com/traefik/traefik-helm-chart

```bash
helm repo add traefik https://traefik.github.io/charts
helm pull traefik/traefik
rm -fr traefik
tar xvf traefik-*.tgz
SOURCE=$(ls -1 traefik-*.tgz)
rm traefik-*.tgz
git add traefik
git commit -m "track chart $SOURCE"
```

## cert-manager

via https://cert-manager.io/docs/installation/helm/

```bash
helm repo add jetstack https://charts.jetstack.io
helm pull jetstack/cert-manager
rm -fr cert-manager
tar xvf cert-manager-*.tgz
SOURCE=$(ls -1 cert-manager-*.tgz)
rm cert-manager-*.tgz
git add cert-manager
git commit -m "track chart $SOURCE"
```

## openfaas

via https://github.com/openfaas/faas-netes/tree/master/chart/openfaas

```bash
helm repo add openfaas https://openfaas.github.io/faas-netes/
helm pull openfaas/openfaas
rm -fr openfaas
tar xvf openfaas-*.tgz
SOURCE=$(ls -1 openfaas-*.tgz)
rm openfaas-*.tgz
git add openfaas
git commit -m "track chart $SOURCE"
```

## istio

via https://istio.io/latest/docs/setup/install/helm/

```bash
helm repo add istio https://istio-release.storage.googleapis.com/charts
mkdir -p istio
pushd istio
for i in base istiod gateway ; do
  helm pull istio/$i
  rm -fr $i
  tar xvf $i-*.tgz
  SOURCE=$(ls -1 $i-*.tgz)
  rm $i-*.tgz
  git add $i
  git commit -m "track chart $SOURCE"
done
popd
```

## knative

via https://knative.dev/docs/install/operator/knative-with-operators/

```bash
SOURCE=https://github.com/knative/operator/releases/download/knative-v1.11.2/operator.yaml
VERSION=$(echo ${SOURCE##*download/} | tr / -)
rm -fr knative
mkdir -p knative
curl -o knative/templates/${VERSION} -L $SOURCE
git add knative
git commit -m "track $VERSION"
```

## pi-hole

via https://github.com/MoJo2600/pihole-kubernetes/blob/master/charts/pihole/README.md

```bash
helm repo add mojo2600 https://mojo2600.github.io/pihole-kubernetes/
helm pull mojo2600/pihole
rm -fr pihole
tar xvf pihole-*.tgz
SOURCE=$(ls -1 pihole-*.tgz)
rm pihole-*.tgz
git add pihole
git commit -m "track chart $SOURCE"
```
