## Install Valheim 

In this lab we are going to install and configure  Valheim. 


### Prerequisites:

We are assuming you are running the Equivalent to the SUSE at Home Base which includes the following:

     * Rancher 2.5+ or 2.6+
     * Kubernetes Cluster (k3s)
        LoadBalancer - Metallb

      * Persistent Storage 
         Storage Class defined and set as Default Storage Class


# Install Valheim 

### 1) Define a namespace for you Application if you have not already done so

### 2) Add Valheim Repo

    Select App & Marketplace -> Chart Repositories
<img src="../../assets/Rancher-ChangetoApps.gif" width="500">


### 3) Click Create to define a new Chart Repository
    
    Name: Valheim
    Index url: https://github.com/Addyvan/valheim-k8s
    
<img src="../../assets/Deploy-Valheim-1-addrepo.png" width="800">

You should now see the Valheim Repo

### 4) Select Charts - You should now see Valheim as an available Chart

<img src="../../assets/Deploy-Valheim-1-app.png" width="300">


### 5) Config and Deploy Valheim 


Click on Install in the upper right to start the install

<img src="../../assets/Deploy-Minecraft-2-install-button.gif" width="800">


### 6) Press Install and watch the Deployment run

### 7) Watch the Valheim Pod's log 

<img src="../../assets/Deploy-Minecraft-5-log.gif" width="900">

### 7) Locate the Valheim Service

    Cluster Explorer -> Services

<img src="../../assets/Deploy-Minecraft-6-Service.gif" width="900">
