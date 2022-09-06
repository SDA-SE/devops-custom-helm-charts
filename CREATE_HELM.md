## Prerequisite

```shell
brew install gh
```

## Helm Package

```shell
thisTag="$(git describe --tags $(git rev-list --tags --max-count=1) --abbrev=0 2>/dev/null || echo "0.0.0" )"
newTag="$(sh ./sem_ver.sh $thisTag release)"
helm package helm/defectdojo --version "${newTag}" -d helm
```

## Update Index

```shell
helm repo index helm/.
```

## Commit and Push

```shell
CHART_PACKAGE_NAME="defectdojo-${newTag}.tgz"
git add helm/index.yaml helm/${CHART_PACKAGE_NAME}
git commit -m "Update chart index"
git push origin master
```

## Create Release

```shell
echo "Create new tag $newTag (old: $thisTag)"
gh release create "$newTag" --title "$newTag" --notes "This is the next release ($newTag)"
gh release upload "$newTag" helm/${CHART_PACKAGE_NAME} --clobber
```
