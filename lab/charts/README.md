# Helm Charts

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

