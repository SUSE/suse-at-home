## Installing Rancher to Manage RKE and K3s

### At the end of the Lab you will have:
* Rancher installed and configured 

### Prerequisites:

  * RKE or K3s installed
  * tux user defined on host with rights to run docker commands
  * DNS working for Rancher server

#### Before you begin you MUST be able to ping your sever via a dns name..
   This could be done with real DNS, local DNS.
   You will Not be able to install Rancher without it ...because we will be generating certs

   You should be connected to your RKE server as the 'tux' user

#### Verify DNS works
```
ping DNS_name
```

# Install cert-manager

### 1) Create a namespace
```
kubectl create namespace cert-manager

Example
namespace/cert-manager created
```
### 2) Add the jetstack repo to helm
```
helm repo add jetstack https://charts.jetstack.io

Example output
https://charts.jetstack.io "jetstack" has been added to your repositories
```

### 3) Refresh helm
```
helm repo update

Example output
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
```
### 4) Install certmanager via helm
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


### 5) Verify rollout
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


# Install Rancher

### 1) Add rancher-latest repo

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest

Example output
"rancher-latest" has been added to your repositories
```
### 2) Update the repo
```
helm repo update

Example output
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "rancher-latest" chart repository
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
```


### 3) Setup Namespace
```
kubectl create namespace cattle-system

Example output
namespace/cattle-system created
```

### 4) Deploy Rancher via helm

### (Option 1) Deploy Rancher via helm - Self-signed Cert (we'll setup NON-HA)

* Replace hostname with your FDQN 

```
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --set hostname=rancher.xyz.com \
  --set replicas=1
```


### (Option 2) - deploy Rancher via helm - LetsEncrypt Cert

* Replace hostname with your FDQN

* Replace letsEncrypt.email with email adress
```
helm install rancher rancher-latest/rancher \
--namespace cattle-system \
--set hostname=rancher.xyz.com \
--set replicas=1 \
--set ingress.tls.source=letsEncrypt \
--set letsEncrypt.email=admin@xyz.com \
--set letsEncrypt.environment=production
```

### 4) Verify Rancher is ready
```
kubectl -n cattle-system rollout status deploy/rancher

Example output
deployment "rancher" successfully rolled out
```
