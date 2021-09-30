## Installing NFS Clients so you can deploy pods with NFS mounts within them

### At the end of the Lab you will have:
* The NFS client installed on any Kubernetes nodes that will run deployments that include NFS mounts

### Prerequisites:

  * Existing NFS Server
  * SLES or Leap install on worker Nodes


# Install NFS Client


### 1) install nfs-client
```
sudo zypper in nfs-client

```

# Test NFS Client

### 1) Create test folder
```
sudo mkdir /tmp/nfstemp


```

### 2) Mount NFS Volume 
```
sudo mount nfs.xyz.com:/share /tmp/nfstemp

Example
```

### 3) verify mount it correct
```
df -h /tmp/nfstemp
```

Example
```
Filesystem                    Size  Used Avail Use% Mounted on
node-6.wiredquill.com:/share   60G  2.5G   56G   5% /tmp/nfstest
```
### 4) Clean up after test
```
sudo umount /tmp/nfstemp

Example
```
