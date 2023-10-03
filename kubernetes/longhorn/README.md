### Add Longhorn Helm Repository
```
helm repo add longhorn https://charts.longhorn.io
```

### Fetch latest charts from the repository
```
helm repo update
```

### Install Longhorn (with Helm 3)

```
helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace --version 1.5.1
```

### Confirm deployment succedded

```
kubectl -n longhorn-system get pod
```

### Expose Longhorn UI through MetalLB
Modifies longhorn-frontend ClusterIP to LoadBalancer
```
kubectl apply -f ./service.yaml
```