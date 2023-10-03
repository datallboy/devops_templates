#! /bin/bash

helm repo add longhorn https://charts.longhorn.io && helm repo update && helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace --version 1.5.1

kubectl -n longhorn-system get pod