## Installing NFS Clients so you can deploy pods with NFS mounts within them

### At the end of the Lab you will have:
* The NFS client install on any Kubernetes nodes that will run deployments that include NFS mounts

### Prerequisites:

  * Existing NFS Server
NFS Clients
  * SLES or Leap install

#### Before you begin you MUST be able to ping your sever via a dns name..
   This could be done with real DNS, local DNS.
   You will Not be able to install Rancher without it ...because we will be generating certs

   You should be connected to your RKE server as the 'tux' user

#### Verify DNS works
```
ping DNS_name
```

# Install NFS Client


### 1) install nfs-client
```
sudo zypper in nfs-client

```

# Test NFS Client

### 1) Create test folder
```
sudo mkdir /tmp/nfstemp

Example
```

### 2) Mount NFS Volume 
```
sudo mount node-6.wiredquill.com:/media /tmp/nfstemp

Example
```

### 3) verify mount it correct
```
ls /tmp/nsftemp

or df -h /tmp/nfstemp


Example
```
### 4) Clean up after test
```
sudo umount /tmp/nfstemp

Example
```
