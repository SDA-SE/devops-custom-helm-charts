# devops-custom-helm-charts

Helm charts with little changes.

```sh
mkdir tmp
cd tmp
helm pull --repo https://raw.githubusercontent.com/DefectDojo/django-DefectDojo/helm-charts defectdojo
tar xvzf defectdojo-*.tgz
rm -rf defectdojo-*.tgz
cd ..
cd helm
rm -rf defectdojo
mv ../tmp/defectdojo .
rmdir ../tmp 
# add changes here
```

Proceed with [CREATE_HELM](CREATE_HELM.md)