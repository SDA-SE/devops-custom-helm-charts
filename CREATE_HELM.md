## Helm Package

```shell
helm package defectdojo --version "0.1.0+$(git rev-parse --short HEAD)" -d helm
```

## Update Index

```shell
helm repo index helm/.
```

## Commit and Push

```shell
CHART_PACKAGE_NAME="defectdojo-0.1.0+$(git rev-parse --short HEAD).tgz"
git add index.yaml ${CHART_PACKAGE_NAME}
git commit -m "Update chart index"
git push origin main
```