## Installing NFS Provisioner 

### At the end of the Lab you will have:
* NFS Provisioner installed and configured to Provision drive space for Kubernetes Deployments on an existing NFS Server

### Prerequisites:

NFS Server
  * Existing NFS Server
  * Share created for /share/k8s-data 

Kubernetes Nodes
  * NFS Client install
  * Manually tested nfs mount to NFS server


# Install NFS Provisioner


### 1) View Existing Storage Classes
```
kubectl get sc
```
Example
```
NAME                   PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  142m
```

### 2) Edit nfs-provisioner.yaml [nfs.server:] and [nfs.path:] to match your NFS server dns/ip and share
```
vi nfs-provisioner.yaml
```
Example
```
apiVersion: helm.cattle.io/v1
kind: HelmChart
metadata:
  name: nfs
  namespace: default
spec:
  chart: nfs-subdir-external-provisioner
  repo: https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
  targetNamespace: default
  set:
    nfs.server: node-6.wiredquill.com
    nfs.path: /share/k8s-data
    storageClass.name: nfs
```

### 2) Deploy nfs-provisioner.yaml
```
kubectl -f nfs-provisioner.yaml

```
Example
```
helmchart.helm.cattle.io/nfs created
```
### 3) Verify Storage Class was created
```
kubectl get sc
```
Example
```
NAME                   PROVISIONER                                         RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
local-path (default)   rancher.io/local-path                               Delete          WaitForFirstConsumer   false                  145m
nfs                    cluster.local/nfs-nfs-subdir-external-provisioner   Delete          Immediate              true                   12s
```

# Test NFS Provisioner

### 1) Create a PVC
```
kubectl apply -f nfs-pvc.yaml
```
### 2) verify PVC

```
kubectl get pvc
```
Example
```
NAME       STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
nfsclaim   Bound    pvc-62bfc6ab-2dd6-4440-ad91-c5d7ff7007b6   100Mi      RWO            nfs            12m
```

### 3) Create test pod to consume pvc
```
kubectl apply -f nfs-test-pod.yaml
```

### 4) Verify creation of PVC and test file on the NFS server

From the NFS server
```
ls -R /share/k8s-data
```

Example:
```
.:
default-nfsclaim-pvc-62bfc6ab-2dd6-4440-ad91-c5d7ff7007b6

./default-nfsclaim-pvc-62bfc6ab-2dd6-4440-ad91-c5d7ff7007b6:
nfs-verified
```