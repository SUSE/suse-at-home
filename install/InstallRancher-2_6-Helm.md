## Installing Rancher 2.6 to Manage RKE and K3s

### At the end of the Lab you will have:
* Rancher installed and configured 

### Prerequisites:

  * RKE or K3s installed
  * DNS working for Rancher server
  * Additional requirements below if using  letsencrypt

#### Before you begin you MUST be able to ping your sever via a dns name..
   This could be done with real DNS, local DNS.
   You will Not be able to install Rancher without it ...because we will be generating certs

   You should be connected to your RKE server as the 'tux' user

#### Verify DNS works
```
ping DNS_name
```

# Install cert-manager


### 1) Add the jetstack repo to helm
```
helm repo add jetstack https://charts.jetstack.io

Example output
https://charts.jetstack.io "jetstack" has been added to your repositories
```

### 2) Refresh helm
```
helm repo update

Example output
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
```
### 3) Install certmanager via helm
```
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.5.1 \
  --set installCRDs=true

Example output
NAME: cert-manager
LAST DEPLOYED: Thu Sep 16 11:40:21 2021
NAMESPACE: cert-manager
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
cert-manager v1.5.1 has been deployed successfully!
```


### 4) Verify rollout
```
kubectl get pods --namespace cert-manager

Example output

NAME                                      READY   STATUS    RESTARTS   AGE
cert-manager-cainjector-75c94654d-mcr87   1/1     Running   0          3m11s
cert-manager-56b686b465-gvks5             1/1     Running   0          3m11s
cert-manager-webhook-69bd5c9d75-dffg9     1/1     Running   0          3m11s
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




### 4) Deploy Rancher via helm

##### (Option 1) Deploy Rancher via helm - Self-signed Cert (we'll setup NON-HA)

* Replace hostname with your FDQN 

* Replace bootstrapPassword with password (This is used just for the initial connection to Rancher)

```
helm install rancher rancher-latest/rancher \
  --namespace cattle-system \
  --create-namespace \
  --set hostname=rancher.xyz.com \
  --set replicas=1
  --set bootstrapPassword=admin
```


##### (Option 2) - deploy Rancher via helm - LetsEncrypt Cert

Requirements for letsencrypt

* Own the domain, or be able to make dns changes to the domain

* Server must be able to accessible from the internet on ports 80/443 by FQDN (rancher.geckofun.org). This means you may need to make changes to your home router to setup port forwarding and dymanicDNS.

* Replace hostname with your FDQN (rancher.geckofun.org)

* Replace bootstrapPassword with password (This is used just for the initial connection to Rancher)

* Replace letsEncrypt.email with your email address

* You can specify a version of Rancher by adding (--version 2.5.9) to the helm command below. 


```
helm install rancher rancher-latest/rancher \
--namespace cattle-system \
--create-namespace \
--set hostname=rancher.xyz.com \
--set replicas=1 \
--set ingress.tls.source=letsEncrypt \
--set letsEncrypt.email=admin@xyz.com \
--set letsEncrypt.environment=production \
--set bootstrapPassword=admin
```

### 5) Verify Rancher is ready
```
kubectl -n cattle-system rollout status deploy/rancher

Example output
deployment "rancher" successfully rolled out
```

### 6) Verifying letsencrypt cert (if you did option 2 above)

    kubectl -n cattle-system describe issuer

```
Example
Spec:
  Acme:
    Email:            erin@suse.com
    Preferred Chain:  
    Private Key Secret Ref:
      Name:  letsencrypt-production
    Server:  https://acme-v02.api.letsencrypt.org/directory
    Solvers:
      http01:
        Ingress:
Status:
  Acme:
    Last Registered Email:  erin@suse.com
    Uri:                    https://acme-v02.api.letsencrypt.org/acme/acct/203517490
  Conditions:
    Last Transition Time:  2021-09-16T21:08:29Z
    Message:               The ACME account was registered with the ACME server
    Observed Generation:   1
    Reason:                ACMEAccountRegistered
    Status:                True
    Type:                  Ready
Events:                    <none>
```

### 7) Troubleshooting 
https://rancher.com/docs/rancher/v2.6/en/installation/resources/troubleshooting/