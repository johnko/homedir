# Helm Charts

## coredns

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
