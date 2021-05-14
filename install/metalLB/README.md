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
kubectl create namespace metallb-system
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
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
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

### 4) Create secret (on run once)
```
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
```
Example
```
secret/memberlist created
```
