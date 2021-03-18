## Installing Rancher to Manage RKE and K3s

##### Before you begin you MUST be able to ping your sever via a dns name..
   This could be done with real DNS, local DNS or just editing your hosts file.
   You will Not be able to install Rancher without it ...because we will be generating certs

###### Verify DNS works
```
ping DNS_name
```

###### Add rancher-latest repo

```
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
Example
"rancher-latest" has been added to your repositories
```
```
helm repo update

Example output
Hang tight while we grab the latest from your chart repositories...
...Successfully got an update from the "rancher-latest" chart repository
...Successfully got an update from the "jetstack" chart repository
...Successfully got an update from the "bitnami" chart repository
Update Complete. ⎈ Happy Helming!⎈
```

In this lab, we are going to install and configure Rancher to Manage RKE and K3s

###### Installing Rancher

You should be connected to your RKE server as the 'tux' user

###### Setup Namespace
```
kubectl create namespace cattle-system

Example
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

Example

deployment "rancher" successfully rolled out
```

#### Add RKE instance to Rancher to be managed (workload cluster)

###### Login to rancher UI
```
Open a browser to https://DNS_name
```
### Add RKE
    1. Hover over the top left dropdown, then click Global
    2. Click Add Cluster
        * The current context is shown in the upper left, and should say 'Global'
        * Note the multiple types of Kubernetes cluster Rancher supports. We will be using Custom for this lab, but there are a lot of possibilities with Rancher.
    3. Click on the From existing nodes (Custom) Cluster box
    4. Enter a name in the Cluster Name box
    5. Set the Kubernetes Version to a v1.16 version
    6. Click Next at the bottom.
    7. Make sure the boxes etcd, Control Plane, and Worker are all ticked.
    8. Click Show advanced options to the bottom right of the Worker checkbox
    9. Enter the Public Address and if on cloud add the Internal Address
        * IMPORTANT: It is VERY important that you use the correct External and Internal addresses from the for this step, and run it on the correct machine. Failure to do this will cause the future steps to fail.
    10. Click the clipboard to Copy to Clipboard the docker run command
