# Installing and Configuring Metal LB

At the end of the Lab you will have:
* MetalLB installed and configure 

### Prerequisites:

- Kubernetes Cluster

# Install MetalLB     

### 1) Create a namespace for Metal LB
```
kubectl create namespace metallb-system
```

### 2) Create a metallb-config.yml file
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
kubectl apply -f metallb-config.yml
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
