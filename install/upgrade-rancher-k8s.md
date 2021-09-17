## Upgrade Rancher and the k8s it is running on

In this lab we are going to upgrade a Rancher Cluster and the K8s that it is running on.


### Prerequisites:

  * Rancher Server running a pervious version
  * Kubernetes Cluster
      * K3s Cluster running a previous version
      * RKE Cluster running a previous version
  * Backup of Rancher Server
   
  

# Upgrade K3s

### 1) Start at a  terminal prompt on your Rancher servers and run the k3s install

    curl -sfL https://get.k3s.io | sh -
```    
Example:
[INFO]  Finding release for channel stable
[INFO]  Using v1.21.4+k3s1 as release
[INFO]  Downloading hash https://github.com/k3s-io/k3s/releases/download/v1.21.4+k3s1/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/k3s-io/k3s/releases/download/v1.21.4+k3s1/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, already exists
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s
```

# Upgrade RKE

### 1) Use the instructions in the link below to download the latest RKE Binary and copy it to /usr/local/bin
    
    https://rancher.com/docs/rke/latest/en/installation/#download-the-rke-binary


### 2) go to the folder that holds your cluster.yml

    rke up --config cluster.yml


# Upgrade Rancher Chart Repos

### 1) Update your local helm repo cache

    helm repo update

### 2) Verify your Repos

    helm repo list
```
Example
NAME          	URL
jetstack      	https://charts.jetstack.io
rancher-latest	https://releases.rancher.com/server-charts/latest
```
### 3) Download Latest Rancher Charts

    helm fetch rancher-latest/rancher


# Upgrade Rancher

### 1) Run the command you ran to install Rancher with the word 'upgrade' replacing the word install

```
helm upgrade rancher rancher-latest/rancher --namespace cattle-system --set hostname=yourhost.fqdn --set replicas=1 
```
### 2) If you don't recall the values you used you can get them with the command below

    helm get values rancher -n cattle-system
