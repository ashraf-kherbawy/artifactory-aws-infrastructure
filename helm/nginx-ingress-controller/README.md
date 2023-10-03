# Nginx Ingress Controller

Since we are deploying Artifactory with an Ingress, we will need an Ingress Controller, in this context we're using the Nginx Ingress Controller. The configuration provided in this
repo is quite simple, so feel free to add more to it as you please.

## Installation using Helm

To deploy the controller with Helm, first add the nginx-ingress repo:
```helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx```
Then install:
```
helm upgrade --install ingress-nginx ingress-nginx \
  --repo https://kubernetes.github.io/ingress-nginx \
  --namespace ingress-nginx -f values.yaml
```

