
Install Helm charts from Artifactory

```
  helm repo add bitnami https://charts.bitnami.com/bitnami
  kubectl config set-context --current --namespace=Playground
  helm install my-mariadb bitnami/mariadb --version 11.4.6
```


Clone Helm chart and customize, then install:

```
  helm pull kronkltd/sqlpad
  helm uninstall my-sqlpad
  helm install -f .\sqlpad\values.yaml my-sqlpad .\sqlpad\
```

