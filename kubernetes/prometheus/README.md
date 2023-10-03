### 1. Add Helm Repo
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
```

### 2. Create namespace for Prometheus
```
kubectl create namespace monitoring
```

### 3. Create Secret
- Modify secret.yml and deploy
  - Data should be base64 encoded
```
kubectl apply -f ./secret.yml
```

### 4. Verify Secret
```
kubectl get secret -n monitoring grafana-admin-credentials -o jsonpath="{.data.admin-user}" | base64 --decode
kubectl get secret -n monitoring grafana-admin-credentials -o jsonpath="{.data.admin-password}" | base64 --decode
```

### 5. Deploy Stack with Helm
```
helm install -n monitoring prometheus prometheus-community/kube-prometheus-stack -f values.yml
```

### 6. (Optional) Test Grafana
```
kubectl port-forward -n monitoring [grafana-abc] 3000:3000
```