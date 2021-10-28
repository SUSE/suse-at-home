## Install Minecraft 

In this lab we are going to install and configure  Minecraft with the option to load custom worlds/maps. 


### Prerequisites:

     * Rancher
     * Kubernetes Cluster
        LoadBalancer - Metallb 

      * Persistent Storage 
         For our Example we will use the NFS Provisioner.


# Install Minecraft

### 1) Add Minecraft Repo (if not already defined)

    Select App & Marketplace -> Chart Repositories
<img src="../../assets/Rancher-ChangetoApps.gif" width="500">


### 2) Click Create to define a new Chart Repository
    
    Name: minecraft
    Index url: https://itzg.github.io/minecraft-server-charts/
    
<img src="../../assets/Rancher-addHelmRepo-Minecraft.gif" width="800">

You should now see the Minecraft Repo


### 3) Select Charts - You should now see Minecraft as an available Chart

<img src="../../assets/Deploy-Minecraft-1-app.png" width="400">


### 4) Config and Deploy PVC for Minecraft 


Click on Values YAML and change/add at a Minimum, change the following items



``` 
minecraftServer:
    eula: 'TRUE'
    motd: Welcome to Minecraft on Kubernetes!
  rcon:
    enabled: true
    password: CHANGEME!
    serviceType: LoadBalancer
  serviceType: LoadBalancer

persistence:
  annotations: {}
  dataDir:
    Size: 1Gi
    enabled: true

resources:
  requests:
    cpu: 1000m
    memory: 1024Mi

        
```
      

<img src="../../assets/Deploy-Minecraft-2-installHelm.png" width="800">

### 5) Config and Deploy PVC for Minecraft 


Click on Values YAML and change/add the following items


### 6) Press Install and watch it deploy

<img src="../../assets/Deploy-Minecraft-3-deployed.png" width="900">

### 7) Locate the Minecraft Service

    Cluster Explorer -> Services

<img src="../../assets/Deploy-Minecraft-4-service.gif" width="900">

# Install Minecraft with NFS PVC

### 1) Check to verify you have a pvc is the namespace you are planning on deploying in

```
kubectle get pvc -A
```

Example
```
NAMESPACE   NAME       STATUS   VOLUME                                     CAPACITY   ACCESS MODES   STORAGECLASS   AGE
default     nfsclaim   Bound    pvc-22295e73-9a25-4b5c-9546-3ec43ba1e23c   10Mi       RWO            nfs            95m
```



### 2) Install Minecraft w/ a pvc Enabled


Click on Values YAML and change/add the following items

``` 

persistence:
  config:
    enabled: enable
    mountPath: /data
    type: pvc
    existingClaim: nfsclaim
  music:
    enabled: enable
    mountPath: /music
    type: custom
    volumeSpec:
      nfs:
        server: node-6.wiredquill.com
        path: /share/music 
    
service:
  main:
  type: LoadBalancer
    ports:
      http:
        port: 4533
        
```