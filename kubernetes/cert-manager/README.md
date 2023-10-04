### 1. Add Jetstack Repo
```
helm repo add jetstack https://charts.jetstack.io
```

### 2. Update Helm repos
```
helm repo update
```

### 3. Create namespace for cert-manager
```
kubectl create namespace cert-manager
```

### 4. Verify namespace was created
```
kubectl get namespaces
```

### 5. Apply custom CRDs for cert-manager (check Github for latest version)
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.13.1/cert-manager.crds.yaml
```

### 6. Modify values.yml to your needs

### 7. Deploy Cert-Manager
```
helm install cert-manager jetstack/cert-manager --namespace cert-manager --values=values.yml --version v1.13.1 
```

### 8. Modify yaml files in issuers to your needs

### 9. Deploy secret and clusterissuer
```
kubectl apply -f issuers
```

### 10. Modify staging/files to your needs

### 11. Deploy staging certificate
```
kubectl apply -f certificates/staging
```

### 12. Use certificate in your ingress 
Deploy nginx as an example