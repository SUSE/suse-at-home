# Traefik Lab

In this Lab you will deploy a simple whoami workload 3 times.

We will then configure 3 diffrent ways to access the workloads.
  * 10.0.0.99   - IP address via MetalLB
  * who.xyz.com - Host name via Traefik
  * traefik-IP/who        - URl path via Traefik

### Prerequisites:

- Kubernetes Cluster (K3s in our Example)
    - Built in Traefik disabled
- Rancher
- MetalLB installed and configured 
- Traefik 2.x installed
- Deployment files from SUSE-AT-HOME/install/traefik


#  IP Address via MetalLB

### 1) Deploy whoami-deploy.yaml

This deployment is a simple whoami workload. 
All objects will be created in the namespace 'who' with a Service Type of LoadBalancer.

Since we selected LoadBalancer, MetalLB will assign the next available IP address.

  ** If you want to assign an specific IP address just add 'LoadBalancerIP: x.x.x.x' right after you assigh type: LoadBalancer


    kubectl apply -f whoami-deploy.yaml

Example

    namespace/who created
    deployment.apps/whoami created
    service/whoami created



### 2) Location SVC IP address

    kubectl get svc -A

Example

```
NAMESPACE     NAME             TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                                     AGE
default       kubernetes       ClusterIP      10.43.0.1       <none>        443/TCP                                     81m
kube-system   kube-dns         ClusterIP      10.43.0.10      <none>        53/UDP,53/TCP,9153/TCP                      81m
kube-system   metrics-server   ClusterIP      10.43.83.49     <none>        443/TCP                                     81m
who           whoami           LoadBalancer   10.43.56.95     10.0.9.201    80:31212/TCP                                3m24s
traefik       traefik          LoadBalancer   10.43.134.192   10.0.9.200    9000:32582/TCP,80:31428/TCP,443:30905/TCP   14m
```

We now see our App 'who' running on IP address 10.0.9.201

### 3) open a browser to http://10.0.9.201

Example
```
Hostname: whoami-6fb5b5d74d-bvqbf
IP: 127.0.0.1
IP: ::1
IP: 10.42.0.13
IP: fe80::acb6:91ff:fe4e:1a63
RemoteAddr: 10.42.0.1:17669
GET / HTTP/1.1
Host: 10.0.9.201
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.5
Connection: keep-alive
Upgrade-Insecure-Requests: 1
```

# Host name via Traefik

### 1) Set a dns entry or hosts file entry to point who.xyz.com to the IP address of Traefik 

    kubectl get svc -n traefik

Example

    NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                                     AGE
    traefik   LoadBalancer   10.43.134.192   10.0.9.200    9000:32582/TCP,80:31428/TCP,443:30905/TCP   20m

Host Config

    who.[xyz].com   10.0.9.200

### 2) Deploy whoami-2-deploy.yaml

This deployment is a simple whoami workload. 
All objects will be created in the namespace 'who2' with a Service Type of ClusterIP.

Since we selected ClusterIP, we will let Traefik handle it

    kubectl apply -f whoami-3-deploy.yaml

Example

    namespace/who2 created
    deployment.apps/whoami created
    service/whoami created


### 3) customize whoami-deploy.yaml to match your host and domain name (who.[xyz].com)

    vi whoami-IngresRoute-host.yaml

### 4) Deploy whoami-IngresRoute-host.yaml

This creates a rule in Traefik to direct anything addressed to the host who.xyz.com to our whoami app running in namespace who2

    kubectl apply -f whoami-IngresRoute-host.yaml

Example

    ingressroute.traefik.containo.us/whoami created

### 5) open a browser to http://who.[xyz].com

Example
```
Hostname: whoami-6fb5b5d74d-bvqbf
IP: 127.0.0.1
IP: ::1
IP: 10.42.0.13
IP: fe80::acb6:91ff:fe4e:1a63
RemoteAddr: 10.42.0.1:17669
GET / HTTP/1.1
Host: 10.0.9.201
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:88.0) Gecko/20100101 Firefox/88.0
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
Accept-Encoding: gzip, deflate
Accept-Language: en-US,en;q=0.5
Connection: keep-alive
Upgrade-Insecure-Requests: 1
```


# URL Path via Traefik

### 1) Deploy whoami-3-deploy.yaml

This deployment is a simple whoami workload. 
All objects will be created in the namespace 'who3' with a Service Type of ClusterIP.

Since we selected ClusterIP, we will let Traefik handle it

    kubectl apply -f whoami-3-deploy.yaml

Example

    namespace/who3 created
    deployment.apps/whoami created
    service/whoami created

### 2) Deploy whoami-IngresRoute-path.yaml

This creates a rule in Traefik to direct anything addressed to Traefik IP/who to our whoami app running in namespace who3

    kubectl apply -f whoami-IngresRoute-path.yaml

Example

    ingressroute.traefik.containo.us/whoami created


### 3) open a browser to http://traffikIP/who

Example
```
