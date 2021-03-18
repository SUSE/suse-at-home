## Installing k3s

In this lab, we are going to import and existing Kubernetes Cluster into Rancher. 
The same steps will work for an RKE, K3s or any other Kubernetes distro

## Prerequisites:
 - running Rancher Server
 - K3s installed on a Raspberry Pi Managed by Rancher

## Step by Step Instructions

### Change the ports Traefik is ussing to 81 and 444

    Select Cluster Explorer -> Services
<img src="../../assets/DeployPi-hole-LoadBalancer-1-Traefik-Select.png" width="900">

    Edit the Traefik Service 
    
<img src="../../assets/DeployPi-hole-LoadBalancer-2-Traefik-Edit.png" width="200">

    Change to ports 81 and 444 and Press Save
<img src="../../assets/DeployPi-hole-LoadBalancer-3-Traefik-Change-Ports.png" width="800">

    You should see the Service Change
<img src="../../assets/DeployPi-hole-LoadBalancer-4-Traefik-complete.png" width="800">

### Add Pi-hole Repo

    Select App & Marketplace -> Chart Repositories
<img src="../../assets/DeployPi-hole-LoadBalancer-5-Chart-Repos.png" width="200">

    Click Create to define a new Chart Repository
    
    Name: Pihole
    Index url: https://mojo2600.github.io/pihole-kubernetes/
    
<img src="../../assets/DeployPi-hole-LoadBalancer-6-Define-Repo.png" width="800">

    You should see now see the Pi-hole Repo
<img src="../../assets/DeployPi-hole-LoadBalancer-7-Repo-Finished.png" width="900">

    Select Chart 
    
    You should now see the option to install pihole
    
    Give it a name 
<img src="../../assets/DeployPi-hole-LoadBalancer-9-Name-Pihole.png" width="900">


    Click on Values YAML and change the following items
    
    persistentVolumeClaim:
      enabled: true
    serviceDns:
      type: LoadBalancer
    serviceWeb:
      type: LoadBalancer
    
    
<img src="../../assets/DeployPi-hole-LoadBalancer-10-Values-Changes.png" width="400">

    Press Install and watch it deploy
<img src="../../assets/DeployPi-hole-LoadBalancer-11-Deploy.png" width="900">

    Wait a couple of mins for it to deploy then open a browser to http://[Raspberry-Pi-IP]/admin/ 
<img src="../../assets/DeployPi-hole-LoadBalancer-12-Admin.png" width="900">

    To take advantage of Pi-Hole change your workstation to use your Raspberry Pi's IP address as the DNS Servers
    
### Testing Pi-hole

    Open a Browser to https://fuzzthepiguy.tech/adtest/ and see you you see ads.
