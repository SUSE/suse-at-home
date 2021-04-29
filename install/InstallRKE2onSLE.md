# Installing RKE2

### Prerequisites:

* Server running a SUSE OS
    * Hostname assigned 
    * DNS setup


# Download and install RKE2



### 1) Run install command

This script will download the RKE2 tarballs, extract in a /tmp directory and subsequently copied to their final locations

```
curl -sfL https://get.rke2.io |sh -
```

### 2) Enable the service
This will enable the service installed via the shell script run previously.

```
systemctl enable --now rke2-server.service
```

#### view the  the logs
If you want to follow the install after enabling the service use the command;
```
journalctl -u rke2-server -f
```
# Optional - Add worker nodes

### 1) Copy the server token
Copy this token from the RKE node you just installed to the clipboard (or have available) in order to add other servers or agents

```
cat /var/lib/rancher/rke2/server/node-token
```

### 2) Setup environment variable for the token

Use the variable below to install an agent (worker) node
```
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
```
### 3) Configure the agent service
Put the IP Address of the server node and paste the token copied above
```
mkdir -p /etc/rancher/rke2
vim /etc/rancher/rke2/config.yaml
server: https://server.node:9345
token: <node-token>
```
### 4) Start and enable the service
```
systemctl enable --now rke2-agent.service
```

### 5) Follow the logs
```
journalctl -u rke2-agent -f
```
### 6) Export the kubeconfig variable and add kubectl to your path
```
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml  PATH=$PATH:/var/lib/rancher/rke2/bin
```
###  7) use kubectl to verify k8s is running
```
kubectl get pods -A
```
DONE.
