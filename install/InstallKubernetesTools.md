### Installing Kubernetes Tools

### At the end of the Lab you will have:
* kubectl installed
* helm 3 installed


### Prerequisites:

* SUSE OS installed

*Note - You can install these tool before or after you install a cluster.

By default both utils use ~/.kube/config for authentication information.
It will be created when you create a cluster

# Installing kubectl

### 1) Connect to Server as tux user (the rest of this lab assumes tux is the user)
```
ssh tux@IP Address
```

### 2)Install the latest kubectl
```
sudo curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

Example output
% Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 41.0M  100 41.0M    0     0  27.9M      0  0:00:01  0:00:01 --:--:-- 27.9M
```
```
sudo mv kubectl /usr/local/bin
sudo chown tux:users /usr/local/bin/kubectl
sudo chmod +x /usr/local/bin/kubectl
```

### 3) Want to add bash completion?
```
(As root, or sudo -i) kubectl completion bash >/etc/bash_completion.d/kubectl
```
Logout and log back in to activate.

### 4) Want to speed up kubectl commands?
```
cat >> ~/.profile <<EOF
alias kubectl='kubectl --cache-dir /dev/shm/${USER}_kube_http_cache'
EOF
```

# Installing Helm


#### Choose 1 of the 3 methods

##### 1. Install helm Manually

```
sudo wget -O helm.tar.gz https://get.helm.sh/helm-v3.4.2-linux-amd64.tar.gz
tar -zxvf helm.tar.gz
sudo mv linux-amd64/helm /usr/local/bin
sudo chmod +x /usr/local/bin/helm
```
##### 2. Install helm via script
```
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
```
##### 3. Install helm via script single command
```
curl -fsSL https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 |bash
```
