# devops-custom-helm-charts

Helm charts with little changes.

## Prerequisite

```shell
brew install gh
```

## DefectDojo

```shell
mkdir tmp
cd tmp
helm pull --repo https://raw.githubusercontent.com/DefectDojo/django-DefectDojo/helm-charts defectdojo
tar xvzf defectdojo-*.tgz

FILE="$(ls -1 defectdojo-*.tgz)"
FILE="${FILE//defectdojo-/}"
VERSION="${FILE//\.tgz/}"

rm -rf defectdojo-*.tgz
cd ../helm
rm -rf defectdojo
mv ../tmp/defectdojo .
rmdir ../tmp 
# add changes here
cd ..
```

## New GH Release information

```shell
git fetch
thisTag="$(git describe --tags $(git rev-list --tags --max-count=1) --abbrev=0 2>/dev/null || echo "0.0.0" )"
newTag="$(sh ./sem_ver.sh ${thisTag} release)"
```

## Helm Package

```shell
helm package helm/defectdojo --version "${VERSION}+SDA.${newTag}" -d helm
```

## Update Index

```shell
URL="https://github.com/SDA-SE/devops-custom-helm-charts/releases/download/${newTag}/"
helm repo index helm/. --merge --url ${URL}
```

## Commit and Push

```shell
CHART_PACKAGE_NAME="defectdojo-${VERSION}+SDA.${newTag}.tgz"
git add helm/defectdojo helm/index.yaml
git commit -m "Update chart index"
git push origin master
```

## Create Release

```shell
echo "Create new tag ${newTag} (old: ${thisTag})"
gh release create "${newTag}" --title "${newTag}" --notes "This is the next release (${newTag})"
gh release upload "${newTag}" helm/${CHART_PACKAGE_NAME} --clobber
rm helm/${CHART_PACKAGE_NAME}
```
