### Installing RKE on SLES 15 SP2

In this lab, we are going to install a single node Kubernetes Cluster using RKE on vms running SLES 15 SP2

Helm 3 client will be installed and Certificate Manager will be deployed in the Kubernetes Cluster

#### Prerequisites

Clean installation of <a href="InstallSLESonx86.md"> SLES 15 SP2 x86_64</a> running "somewhere".
This machine can be a local VM or an instance in the Cloud.

Enable the Containers Module
'''
SUSEConnect -p sle-module-containers/15.2/x86_64
'''

Make sure  you install the Kubernetes  Tools before starting this lab

<a href="InstallKubernetesTools.md">Installation of Kubernetes  Tools</a>

###### Connect to Server
###### as tux user (the rest of this lab assumes tux is the user)
```
ssh tux@IP Address
```

###### Test the Docker service is running and the tux user can issue docker commands
```
docker ps

 Example

     CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

###### Create SSH keys
```
ssh-keygen -b 2048 -t rsa -N ""

Example

Generating public/private rsa key pair.
Enter file in which to save the key (/root/.ssh/id_rsa):
Created directory '/root/.ssh'.
Your identification has been saved in /root/.ssh/id_rsa.
Your public key has been saved in /root/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:EF3Z1mIeoO1zt5EPB7pmheoToy9e9y5D8Hpo3riTvII root@rke-erin-1
The key's randomart image is:
+---[RSA 2048]----+
|      .. .o+ .   |
|       ..o. * .  |
|      . . .+ o.  |
|       . .. .o o |
|        S oo+ * .|
|          o+o+ * |
|       . ooB= . .|
|      E +oO*+.   |
|       ..*B*.+o  |
+----[SHA256]-----+
```


###### Add keys
```
cat /home/tux/.ssh/id_rsa.pub >> /home/tux/.ssh/authorized_keys
```

###### Exchange keys if you have more than one node
Use ssh-copy-id to exchange the keys from each VM, execute this on each VM.
```
ssh-copy-id -i /home/tux/.ssh/id_rsa.pub tux@<ip-other-vm>
```

###### Download RKE
```
sudo wget -O /usr/local/bin/rke https://github.com/rancher/rke/releases/download/v1.2.5/rke_linux-amd64

Example output

/usr/local/bin/rke                     100%[=========================================================================>]  40.30M  13.9MB/s    in 2.9s

2020-10-14 16:28:41 (13.9 MB/s) - ‘/usr/local/bin/rke’ saved [42256431/42256431]
```

###### Copy the rke binary to /usr/local/bin
```
sudo chown tux:users /usr/local/bin/rke
sudo chmod +x /usr/local/bin/rke
```

#### Create RKE Config file

###### Create cluster.yml with the text below
```
rke config --name cluster.yml
```

###### Take the default answers for all questions with the exception of the following items:
```
SSH Address of host should be set to your current Host's IP address

[+] Number of Hosts [1]: 1
[+] SSH Address of host (1) [none]: 10.0.5.35
[+] SSH User of host (10.0.5.35) [ubuntu]: tux
[+] Is host (10.0.5.35) a Worker host (y/n)? [n]: y
[+] Is host (10.0.5.35) an etcd host (y/n)? [n]: y
```
###### basic cluster.yml example
```
cat <<EOF> cluster.yml
nodes:
  - address: $(nodeIP)
    user: tux
    role:
     - controlplane
     - etcd
     - worker
addon_job_timeout: 120
EOF
```
###### Edit cluster.yml to increase addon_job_timeout

    vi cluster.yml
    change addon_job_timeout: 120

###### Install RKE

```
rke up --config cluster.yml

Example output

INFO[0000] Running RKE version: v1.1.6
INFO[0000] Initiating Kubernetes cluster
INFO[0000] [dialer] Setup tunnel for host [10.0.9.203]
INFO[0000] Checking if container [cluster-state-deployer] is running on host [10.0.9.203], try #1
INFO[0000] Pulling image [rancher/rke-tools:v0.1.64] on host [10.0.9.203], try #1
INFO[0007] Image [rancher/rke-tools:v0.1.64] exists on host [10.0.9.203]
...
INFO[0159] [addons] Successfully saved ConfigMap for addon rke-ingress-controller to Kubernetes
INFO[0159] [addons] Executing deploy job rke-ingress-controller
INFO[0174] [ingress] ingress controller nginx deployed successfully
INFO[0174] [addons] Setting up user addons
INFO[0174] [addons] no user addons defined
INFO[0174] Finished building Kubernetes cluster successfully
```

###### Problem with your rke install?
#### You can alway remove your rke install using

```
rke remove
```

###### Create symlink for kubeconfig
```
mkdir /home/tux/.kube
cp kube_config_cluster.yml /home/tux/.kube/config
chmod 600 /home/tux/.kube/config
```
OR symlink it
```
ln -s /home/tux/kube_config_cluster.yml /home/tux/.kube/config
```

###### Verify your node is running
```
kubectl get nodes

Example

NAME        STATUS   ROLES                      AGE     VERSION
10.0.5.35   Ready    controlplane,etcd,worker   2m12s   v1.18.6
```


