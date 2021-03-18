## Configuring Node Red with Storage

In this lab, we are going to install Node Red running as a Deployment using the Local Storage Provider for Storage

Prerequisites:
     Raspberry Pi running SLES 15 SP2
     K3s installed

### Deploy Node-Red using the local-path-provisioner on K3s & create a service to expose the deployment

    kubectl create -f nodered-deployment.yaml
    kubectl create -f nodered-service-lb.yaml


### Locate IP address of Node-Red

    kubectl get svc -n nodered

Example:

```
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
nodered   LoadBalancer   10.43.233.129   10.0.11.102   80:31063/TCP   8m33s
```

This example tells us that Node-Red is now available on 10.0.11.102 on port 80
