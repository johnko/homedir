# Helm Charts

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

## nginx ingress controller

via https://github.com/kubernetes/ingress-nginx/tree/main/charts/ingress-nginx

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm pull ingress-nginx/ingress-nginx
rm -fr ingress-nginx
tar xvf ingress-nginx-*.tgz
SOURCE=$(ls -1 ingress-nginx-*.tgz)
rm ingress-nginx-*.tgz
git add ingress-nginx
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
