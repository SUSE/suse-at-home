## Installing Rancher to Manage RKE and K3s

In this lab, we are going to install and configure Rancher to Manage RKE and K3s


##### Before you begin you MUST be able to ping your sever via a dns name..
   This could be done with real DNS, local DNS or just editing your hosts file.
   You will Not be able to install Rancher without it ...because we will be generating certs

   You should be connected to your RKE server as the 'tux' user

###### Verify DNS works
```
ping DNS_name
```

#### Install cert-manager

###### Create a namespace
```
kubectl create namespace cert-manager

Example
namespace/cert-manager created
```
###### Add the jetstack repo to helm
```
helm repo add jetstack https://charts.jetstack.io

Example output
https://charts.jetstack.io "jetstack" has been added to your repositories
```

###### Refresh helm
```
helm repo update

Example output
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
```
###### Install certmanager via helm
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.2.0 \
  --set installCRDs=true

Example output
NAME: cert-manager
LAST DEPLOYED: Tue Sep  8 10:51:54 2020
NAMESPACE: cert-manager
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager has been deployed successfully!
```


###### Verify rollout
```
kubectl -n cert-manager rollout status deploy/cert-manager-webhook

Example output
deployment "cert-manager-webhook" successfully rolled out
```

```
kubectl -n cert-manager rollout status deploy/cert-manager

Example output
deployment "cert-manager" successfully rolled out
```


#### Install Rancher
###### Add rancher-latest repo

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

Example output
"rancher-latest" has been added to your repositories
```
###### update the repo
```
helm repo update

Example output
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "rancher-latest" chart repository
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
```


###### Setup Namespace
```
kubectl create namespace cattle-system

Example output
namespace/cattle-system created
```

##### deploy Rancher via helm (we'll setup NON-HA)

```
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=$(DNS_name) \
  --set replicas=1
```

###### Verify Rancher is ready
```
kubectl -n cattle-system rollout status deploy/rancher

Example output
deployment "rancher" successfully rolled out
```
