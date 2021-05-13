# Installing Traefik

In this Lab you will install and configure Traefik to help with incomming (ingress) requests 

### Prerequisites:

- Kubernetes Cluster (K3s in our Example)
    - Built in Traefik disabled
- Rancher
- MeatalLB installed and configured 


#  Add Traefik Repo

### 1) Create traefik Namespace

<img src="../assets/Traefik-Install-1-Namespace.gif" width="300">

### 2) Select Charts Repo

    Select App & Marketplace -> Chart Repositories
<img src="../assets/Rancher-ChangetoApps.gif" width="300">

### 3)    Click Create to define a new Chart Repository
    
    Name: Traefik
    Index url: https://helm.traefik.io/traefik
    
<img src="../assets/Traefik-Install-1-repos.gif
" width="800">

    You should see now see the Traefik Repo

<img src="../assets/Traefik-Install-2-repos.png" width="900">

#  Install Traefik

### 1) Select Traefik Chart

    Select Chart 
    
    You should now see the option to install traefik

<img src="../assets/Traefik-Install-3-Select-Traefik.gif" width="900">

### 2) Deploy Traefik
    
    Select the Namespace traefik
    Name the Deploymen trefik 
<img src="../assets/Traefik-Install-5-Deploy.gif" width="900">


#  Locate Traefik IP address

### 1) Access kubectl

    Access kubectl either Rancher interface (as shown) or from a terminal

<img src="../assets/Traefik-Install-6-Terminal.gif" width="200">


### 2) Find traefik's IP address

    kubectl get svc -A
<img src="../assets/Traefik-Install-7-Locate-svc.gif" width="800">

    This tells us Traefik is running on IP address 10.0.22.1

# Access Traefik Dashboard

### 1) Open a broswer to 10.0.22.1:9000/dashboard/

<img src="../assets/Traefik-Install-8-Dashboard.png" width="800">

