## Installing Longhorn 

### At the end of the Lab you will have:

- Longhorn installed and setup as the Default StorageClass for your Cluster

### Prerequisites:

- Rancher up and running
- Target Cluster that you want to install Longhorn into
    - Longhorn uses /var/lib/longhorn one the nodes of the Cluster to store data

### Installation of Lonnghorn
#### Step by Step Instructions
 
    From a browser, go to your Rancher Cluster Explorer and make sure you have the Target Cluster selected 


<img src="../assets/Longhorn-1-Select-Cluster.png" width="600">


    Select Apps & Marketplace from the dropdown menu

<img src="../assets/Longhorn-2-Apps.png" width="200">


    From the Charts Menu, select Longhorn


<img src="../assets/Longhorn-3-charts.png" width="800">

    *If you want to change the default path used by Longhorn click 'Customize Default Settings'

<img src="../assets/Longhorn-4-Change-Defaults.png" width="600">

    Click install and you are Done!

<img src="../assets/Longhorn-5-Install.png" width="600">

### Lonnghorn Console

    Once Lognhorn is installed, you can access the console by simply Selecting it in the Upper Left hand Menu and Click on the Longhorn Icon to launch the console

<img src="../assets/Longhorn-Console-1.png" width="300">



    Notice in the console we don't have any Volumes yet


<img src="../assets/Longhorn-Console-2-no-volumes.png" width="800">

### Test Longhorn

```
Create a test-pvc.yml  

# test-pvc.yml 
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: test-pvc
spec:
  storageClassName:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 5Gi

```

```
Create a test-deplyment.yml

# test-deplyment.yml
kind: Pod
apiVersion: v1
metadata:
  name: test-pvc-pod
spec:
  volumes:
  - name: debug-pv
    persistentVolumeClaim:
      claimName: test-pvc
  containers:
  - name: debugger
    image: busybox
    command: ["sleep", "3600"]
    volumeMounts:
    - mountPath: "/data"
      name: debug-pv
```


Deploy the PVC and the Deployment

```
    kubectl apply -f test-pvc
    kubectl apply -f test-deplyment.yml
```

Look at the Longhorn Dashboard - You now see a volume created

<img src="../assets/Longhorn-Console-3-Deployed.png" width="800">
