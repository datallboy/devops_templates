## PureLB Setup

```
$ helm repo add purelb https://gitlab.com/api/v4/projects/20400619/packages/helm/stable
$ helm repo update
$ helm install --create-namespace --namespace=purelb purelb purelb/purelb
```

Update subnet and IP range pool to fit your needs.

`service-example.yml` is an example NGINX LoadBalancer service using PureLB