# Helm Charts

```bash
cd ./lab/renovatebotwrapper && helm dep update && cd ./charts && ls -1 *.tgz | xargs -I{} -P1 tar xvf {} && rm *.tgz
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
