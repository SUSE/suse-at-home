# Installing k3s on a SUSE OS

### At the end of the Lab you will have:
* K3s install and configure k3s on a Raspberry Pi


### Prerequisites:

* x86 or Raspberry Pi server
* SUSE OS installed (SLE 15sp2,SLE Micro, Leap)

# Installing K3s

### 1) Open a Terminal and ssh to you host

    ssh tux@x.x.x.x

### 2)Update to the latest patches
```
sudo zypper up
```
### 3) Ensure you have the needed packages
```
sudo zypper in which
```
### 4) Punch a hole in the firewall or turn it off
```
firewall-cmd --zone=public --add-port=6443/tcp --permanent
firewall-cmd --reload
```
OR disable and turn off
```
sudo systemctl disable --now firewalld
```
### 5) Install k3s via the automated script

We are using the --write-kubeconfig-mode 644 option so the .kube/config file is automatically created
```
curl -sfL https://get.k3s.io | INSTALL_K3S_VERSION=v1.19.8+k3s1 K3S_KUBECONFIG_MODE=0644 sh - 
```
The output will look simular to:

```
[INFO]  Finding release for channel stable
[INFO]  Using v1.18.8+k3s1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v1.18.8+k3s1/sha256sum-arm64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v1.18.8+k3s1/k3s-arm64
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Creating /usr/local/bin/kubectl symlink to k3s
[INFO]  Creating /usr/local/bin/crictl symlink to k3s
[INFO]  Creating /usr/local/bin/ctr symlink to k3s
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s
```

### 6) Test to see if it's working
```
kubectl get nodes
```
Example:

```
NAME        STATUS   ROLES    AGE   VERSION
pi-erin-1   Ready    master   55s   v1.18.9+k3s1
```
### 7) Want to add bash completion?
```
kubectl completion bash >/etc/bash_completion.d/kubectl
```
Logout and log back in to activate.

### 8) Need helm to work?

First, Follow the instructions to install Helm in the <a href="InstallKubernetesTools.md">Installation of Kubernetes  Tools</a>

You will not need to install kubectl since the k3s install already did that for you.

### 9) Export the k3s.yaml
```
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
```
or you can symlink it
ensure you have .kube/config in your home directory
for tux use
```
ln -s /etc/rancher/k3s/k3s.yaml /home/tux/.kube/config
```

Done. Time to move on to adding a workload.


