# Lesson Edge - Deploy MQTT for the sensors to talk to

In this lab we are going to install and configure an MQTT Workload to run on k3s or RKE cluster

There are 2 methods provided to install MQTT, the Easy Method with Rancher and Helm, or the Manual Method which include the needed yaml files. 

### Prerequisites:

     Rancher
     Kubernetes Cluster
        Default StorageClass
        LoadBalancer

# Easy Method via Rancher and Helm

### 1) Add k8s-at-home Repo

    Select App & Marketplace -> Chart Repositories
<img src="../../assets/Rancher-ChangetoApps.gif" width="300">


### 2) Click Create to define a new Chart Repository
    
    Name: k8s-at-home
    Index url: https://k8s-at-home.com/charts/
    
<img src="../../assets/Rancher-addHelmRepo-k8s-at-home.gif" width="600">

You should now see the k8s-at-home Repo


### 3) Select Charts - You should now see Mosquitto as an available Chart

<img src="../../assets/Deploy-mosquitto-1-app.png" width="400">


### 4) Install Mosquitto 


Click on Values YAML and change the following items
    
    service:
      type: LoadBalancer
<img src="../../assets/Deploy-mosquitto-2-installHelm.png" width="600">


### 5) Press Install and watch it deploy

<img src="../../assets/Deploy-mosquitto-3-deployed.png" width="900">




# Manual Method 

### 1) Deploy MQTT using the local-path-provisioner 

For x86

    kubectl create -f nodered-deployment.yaml
For Raspberry Pi

    kubectl create -f nodered-Raspberry-Pi-deployment.yaml
### 2) Deploy the Service

    kubectl create -f nodered-service-lb.yaml


### 3) Locate IP address of Node-Red

    kubectl get svc -n nodered

Example:

```
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
mqtt   LoadBalancer   10.43.233.129   10.0.11.102   80:31063/TCP   8m33s
```

This example tells us that Node-Red is now available on 10.0.11.102 on port 1883
