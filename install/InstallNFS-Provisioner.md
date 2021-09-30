## Installing NFS Server and NFS Clients so you can deploy pods with NFS mounts within them

### At the end of the Lab you will have:
* An NFS Server running on a SLES Server
* The NFS client install on any Kubernetes nodes that will run deployments that include NFS mounts

### Prerequisites:

NFS Server
  * Existing NFS Server
  * or SLES 15 or Leap installed

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

# Install NFS Server

