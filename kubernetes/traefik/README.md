### 1. Create Namespace for Traefik
```
kubectl create namespace traefik
```

### 2. Verify namespace was created
```
kubectl get namespaces
```

### 3. Add Traefik helm repo
```
helm repo add traefik https://helm.traefik.io/traefik
```

### 4. Update local repo
```
helm repo update
```

### 5. Modify values.yml file to your needs

### 6. Install Traefik using Helm
```
helm install --namespace=traefik traefik traefik/traefik --values=values.yml
```

### 7. Verify deployment
```
kubectl get svc -n traefik -o wide
```

### 8. Modify default-headers.yml file to your needs

### 9. Deploy Middleware
```
kubectl apply -f default-headers.yml
```

### 10. Verify Middleware
```
kubectl get middleware
```

### 11. Created base64 encoded htaccess credentials
```sh
htpasswd -nb admin password | openssl base64
```

### 12. Modify dashboard/secret-example.yml file to your needs

### 13. Deploy secret
```
kubectl apply -f dashboard/secret.yml
```

### 14. Verify secret
```
kubectl get secret -n traefik
```

### 15. Modify dashboard/middleware.yml file to your needs

### 16. Deploy Middleware for auth
```
kubectl apply -f dashboard/middleware.yml
```

### 17. Verify Middleware deployed
```
kubectl get middleware -n traefik
```

### 18. Modify IngressRoute to your needs

### 19. Deploy IngressRoute
```
kubectl apply -f dashboard/ingress.yml
```

### 20. Verify IngressRoute was created
```
kubectl get ingressroute -n traefik
```