# Installing and Configuring Metal LB

At the end of the Lab you will have:
* MetalLB installed and configured 

### Prerequisites:

- Kubernetes Cluster
- K3s - traefik and klipper (servicelb) disabled (see below for instructions)


### K3s Installs Traefik 1.8) by default.  You can stop Traefik from installing with '--disable=traefik' during your k3s install or delete the helm deployment. You also need to disable the service loadbalancer (klipper) using '--disable=servicelb'
  
  For Example 

    curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=0644 sh -s - --disable=traefik --disable=servicelb


# Install MetalLB     


### 1) Create a namespace for Metal LB
```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/namespace.yaml
```

### 2) Create a metallb-config.yaml file
Ensure the addresses match the available addresses in your configuration
Edit or create a metallb-config.yml with the following entries

*Note this example will give the addresses 10.0.0.100-120 to the LoadBalancer

```
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: metallb-system
  name: config
data:
  config: |
    address-pools:
    - name: default
      protocol: layer2
      addresses:
      - 10.0.0.100-10.0.0.120
```

```
kubectl apply -f metallb-config.yaml
```
### 3) Download and deploy metallb.yaml 

```
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.10.2/manifests/metallb.yaml
```
Example
```
podsecuritypolicy.policy/controller created
podsecuritypolicy.policy/speaker created
serviceaccount/controller created
serviceaccount/speaker created
clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
role.rbac.authorization.k8s.io/config-watcher created
role.rbac.authorization.k8s.io/pod-lister created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
rolebinding.rbac.authorization.k8s.io/config-watcher created
rolebinding.rbac.authorization.k8s.io/pod-lister created
daemonset.apps/speaker created
deployment.apps/controller created
```

# Testing Metal LB

### 1) Deploy whoami app using Metallb
```
kubectl apply -f whoami-deploy.yaml
```

### 2) Locate the IP of the whoami service

```
kubectl get svc -A
```

Example
```
who    whoami  LoadBalancer   10.43.21.89     10.0.0.100   80:31247/TCP
```

### 3) Test whoami App

```
Open a browser to http://10.0.0.100
```

Example
```
Hostname: whoami-6fb5b5d74d-ln65d
IP: 127.0.0.1
IP: ::1
IP: 10.42.0.14
IP: fe80::c803:2eff:fee7:88a2
RemoteAddr: 10.42.0.1:46713
GET / HTTP/1.1
Host: 10.0.24.101
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.1.2 Safari/605.1.15
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-us
Connection: keep-alive
Upgrade-Insecure-Requests: 1
```