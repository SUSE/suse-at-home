## Using Rancherd to standup rke2 and rancher together

The commands below will require root access. Suggesting using
```
sudo -s
```
to run the following commands

##### Download and install the rancherd binary
```
curl -sfL https://get.rancher.io | sh -
```

##### Enable and start the service
```
systemctl enable --now rancherd-server.service
```

##### Use journalctl to view the logs for the service if you wish
```
journalctl -eu rancherd-server -f
```
##### Export the kubeconfig variable and add kubectl to your path
```
export KUBECONFIG=/etc/rancher/rke2/rke2.yaml  PATH=$PATH:/var/lib/rancher/rke2/bin
```
##### use kubectl to verify the rancher container is running, then;
```
kubectl get pods -n cattle-system
```
##### ...set the Rancher password
```
rancherd reset-admin
```
Follow the url and use the password provided from the command above and login to Rancher
