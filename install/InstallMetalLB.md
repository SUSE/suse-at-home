## Installing and Configuring Metal LB

In this lab, we are going to install and configure Metal LB

#### Create a namespace for Metal LB
```
# kubectl create namespace metallb-system
```

#### Create a metallb.yml file
Ensure the addresses match the available addresses in your configuration
Edit or create a metallb.yml with the following entries
```
configInline:
  address-pools:
  - name: default
    protocol: layer2
    addresses:
    - 192.168.121.240-192.168.121.250
```

#### Install MetalLB with Helm
```
# helm install metallb \
--namespace metallb-system \
stable/metallb -f metallb.yml
```

watch the pods come up
```
# watch -c "kubectl get po -n metallb-system"
```

Any install using a LoadBalancer will now grab one of these IP Addresses.
