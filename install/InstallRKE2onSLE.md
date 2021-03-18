### RKE2 setup on SLES15 SP2
Adapted from https://docs.rke2.io/install/quickstart/
#### Requires at least 1 SLE15 SP2 machine.
Requires unique hostnames or the node-name parameter set in /etc/rancher/rke2/config.yaml

Multiple nodes require several TCP/UDP ports to be configured properly. Refer to the docs link above for details.

##### Download and install RKE2
In SLES this script will download the RKE2 tarballs, extract in a /tmp directory and subsequently copied to their final locations

```
curl -sfL https://get.rke2.io |sh -
```

##### Enable the service
This will enable the service installed via the shell script run previously.

```
systemctl enable --now rke2-server.service
```

##### Follow the logs
If you want to follow the install after enabling the service use the command;
```
journalctl -u rke2-server -f
```

##### Copy the server token
You will need to copy this token to the clipboard (or have available) in order to add other servers or agents

```
cat /var/lib/rancher/rke2/server/node-token
```

##### Add worker nodes
Use the variable below to install an agent (worker) node
```
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
```
##### Configure the agent service
Put the IP Address of the server node and paste the token copied above
```
mkdir -p /etc/rancher/rke2
vim /etc/rancher/rke2/config.yaml
server: https://server.node:9345
token: <node-token>
```
##### Start and enable the service
```
systemctl enable --now rke2-agent.service
```

#### Follow the logs
```
journalctl -u rke2-agent -f
```
##### Export the kubeconfig variable and add kubectl to your path
```
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml  PATH=$PATH:/var/lib/rancher/rke2/bin
```
##### use kubectl to verify k8s is running
```
kubectl get pods -A
```
DONE.
