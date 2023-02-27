
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
  helm install -f values.yaml my-sqlpad kronkltd/sqlpad --version 0.1.0
  helm upgrade -f values.yaml my-sqlpad kronkltd/sqlpad --version 0.1.0
```

