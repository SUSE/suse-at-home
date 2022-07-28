# Installing and Configuring Metal LB

At the end of the Lab you will have:
* MetalLB installed and configured 

### Prerequisites:

- Kubernetes Cluster
- K3s - traefik and klipper (servicelb) disabled (see below for instructions)


> K3s Installs Traefik 1.8) by default.  You can stop Traefik from installing with '--disable=traefik' during your k3s install or delete the helm deployment. You also need to disable the service loadbalancer (klipper) using '--disable=servicelb'
  
  For Example 
```
curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE=0644 sh -s - --disable=traefik --disable=servicelb
```

# Install MetalLB     

### 1) Install MetalLB 

```cosnole
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.13.4/config/manifests/metallb-native.yaml
```
Example
```
namespace/metallb-system configured
customresourcedefinition.apiextensions.k8s.io/addresspools.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bfdprofiles.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bgpadvertisements.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bgppeers.metallb.io created
customresourcedefinition.apiextensions.k8s.io/communities.metallb.io created
customresourcedefinition.apiextensions.k8s.io/ipaddresspools.metallb.io created
customresourcedefinition.apiextensions.k8s.io/l2advertisements.metallb.io created
serviceaccount/controller created
serviceaccount/speaker created
Warning: policy/v1beta1 PodSecurityPolicy is deprecated in v1.21+, unavailable in v1.25+
podsecuritypolicy.policy/controller created
podsecuritypolicy.policy/speaker created
role.rbac.authorization.k8s.io/controller created
role.rbac.authorization.k8s.io/pod-lister created
clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
rolebinding.rbac.authorization.k8s.io/controller created
rolebinding.rbac.authorization.k8s.io/pod-lister created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
secret/webhook-server-cert created
service/webhook-service created
deployment.apps/controller created
daemonset.apps/speaker created
validatingwebhookconfiguration.admissionregistration.k8s.io/metallb-webhook-configuration created
```

### 2) Create a metallb-config.yaml file
Ensure the addresses match the available addresses in your configuration.
Edit or create a `metallb-config.yaml` with the following entries

*Note this example will give the addresses `10.0.0.100-120` to the LoadBalancer

```yaml
apiVersion: metallb.io/v1beta1
kind: IPAddressPool
metadata:
  name: first-pool
  namespace: metallb-system
spec:
  addresses:
  - 10.0.0.100-10.0.0.120
```

```console
kubectl apply -f metallb-config.yaml
```

### 3) Announce the service IPs
The last step is to configure how MetalLB annouces the service. The simplest method is is to respond to ARP requests.   
Make sure `spec.ipAddressPools` selector selects the correct IPAddressPool resource.
[Read more](https://metallb.universe.tf/configuration/) about diffrent ways announce service IP.

```yaml
apiVersion: metallb.io/v1beta1
kind: L2Advertisement
metadata:
  name: example
  namespace: metallb-system
spec:
  ipAddressPools:
  - first-pool
```

```console
kubectl apply -f metallb-L2Advert.yaml
```

# Testing MetalLB

### 1) Deploy whoami app using MetalLB
```console
kubectl apply -f https://raw.githubusercontent.com/SUSE/suse-at-home/main/install/metalLB/whoami-deploy.yaml
```

### 2) Locate the IP of the whoami service

```console
kubectl get svc -n who
```

Example
```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP    PORT(S)        AGE
whoami   LoadBalancer   10.43.21.89    10.0.0.100     80:31247/TCP   21m
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


### 4) Clean Up

```console
kubectl delete -f https://raw.githubusercontent.com/SUSE/suse-at-home/main/install/metalLB/whoami-deploy.yaml
```