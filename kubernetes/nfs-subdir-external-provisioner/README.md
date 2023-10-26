## Add NFS StorageClass

```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner/
helm install nfs-subdir-external-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner \
    --set nfs.server=192.168.10.6 \
    --set nfs.path=/mnt/datastore/k3s-storage
```

Update `nfs.server` and `nfs.path` to fit your needs