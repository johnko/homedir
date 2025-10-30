# Helm Charts

```bash
echo >> lab/renovatebotwrapper/values.yaml
.github/helm-dep.sh
```

## knative

via https://knative.dev/docs/install/operator/knative-with-operators/

```bash
SOURCE=https://github.com/knative/operator/releases/download/knative-v1.19.5/operator.yaml
VERSION=$(echo ${SOURCE##*download/} | tr / -)
rm -fr knative/templates
mkdir -p knative/templates
curl -o knative/templates/${VERSION} -L $SOURCE
git add knative
git commit -m "track $VERSION"
```
