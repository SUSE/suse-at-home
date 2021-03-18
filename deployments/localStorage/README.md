## Configuring local Storage

In this lab, we are going to configure a Local Storage Provider

## Create a hostPath backed persistent volume claim and a pod to utilize it

    kubectl create -f pv.yaml
    kubectl create -f pvc.yaml

    k3s kubectl get pv
    k3s kubectl get pvc

### Test local path

    kubectl create -f pod.yaml

    kubectl exec --stdin --tty volume-test -- bin/sh

    touch /data/testfile
    exit

    kubectl delete -f pod.yaml


Examine where the files were stored on the node

    ls /opt/local-path-provisioner
