# SUSE at Home

## Objectives

* Give a hands-on experience with some of our newer technologies including Kubernetes and Rancher

* Provide a base of SLES, Kubernetes and Rancher that you can then deploy applications to make your life better

## Suggested Installation Paths

Production Rancher Installation - SLES+RKE+Rancher
* <a href="install/InstallSLESonx86.md">Install SLES15 SP2 on x86_64</a>
* <a href="install/InstallKubernetesTools.md">Install Kubernetes  Tools</a> 
* <a href="install/InstallRKEonSLES15x86_64.md">Install RKE on SLES</a> 
* <a href="install/InstallRancher-Helm.md">Install Rancher using helm</a>

RKE 2 Based Rancher Installation - SLES+RKE2+Rancher
* <a href="install/InstallSLESonx86.md">Install SLES15 SP2 on x86_64</a>
* <a href="install/InstallKubernetesTools.md">Install Helm</a> 
* <a href="install/InstallRancher-Rancherd.md">Install of Rancher on RKE2 using Rancherd</a>

K3s Rancher Install - SLES+K3s+Rancher
* <a href="install/InstallSLESonx86.md">Install SLES15 SP2 on x86_64</a>
* <a href="install/InstallK3s.md">Install K3s</a>
* <a href="install/InstallKubernetesTools.md">Install Helm</a> 
* <a href="install/InstallRancher-Helm.md">Install Rancher using helm</a>


Install K3s on Raspberry Pi
* <a href="install/InstallSLESonRPi.md">Installation of SLES15 SP2 on Raspberry Pi/aarch64</a>
* <a href="install/InstallK3s.md">Install K3s</a>
## What's here

### Install - /install 
    All information on how go from metal until you have SLES, Kubernetes 
    (RKE or K3s) and Rancher 
    
    This is where you should start...even if you have SLES install just look.
    Make sure you have the proper packages intalled and enabled, turn off or 
    open up the firewall and make sure you setup the ssh-keys.

### Install SLES
    Pick one of the methods below to install SLES

- <a href="install/InstallSLESonx86.md">Installation of SLES15 SP2 on x86_64</a>
- <a href="install/InstallSLESonRPi.md">Installation of SLES15 SP2 on Raspberry Pi/aarch64</a>

- <a href="install/InstallSLESonRPi-USB.md">Installation and booting of SLES15 SP2 on x86_64 using USB</a>

- <a href="install/InstallSLE15-JeOS-KVM-Cloud-init.md">Setup cloud-init for KVM installs</a>
- <a href="https://github.com/zoopster/junk/tree/master/tf-sles15-cloudinit">Terraform install of SLES on KVM</a>

### Install Kubernetes Tools   
* <a href="install/InstallKubernetesTools.md">Installation of Kubernetes  Tools</a> 

### Installing Kubernetes

- RKE - Full Blown Kubernetes
  - <a href="install/InstallRKEonSLES15x86_64.md">Simple single-node RKE install on SLES15 SP2 x86_64</a>
- RKE2 (Rancher Government)
  - <a href="install/InstallRKE2onSLE.md">Install RKE2 (RKE Government) on SLES15 SP2 x86_64</a>
- K3s - Lightweight w/ batteries 
  - <a href="install/InstallK3s.md">Install K3s</a>


### Install Rancher
    We have a couple of options for Rancher.

    Rancher normally runs on top of Kubernetes. You pick any of our 
    Kubernetes (RKE, RKE2 or K3s) and then install Rancher via helm.  





- Rancher
  - <a href="install/InstallRancher-Docker.md">Quick install of Rancher using docker</a>
  - <a href="install/InstallRancher-Rancherd.md">Quick install of Rancher on RKE2 using Rancherd</a>
  - <a href="install/InstallRancher-Helm.md">Using helm to install Rancher on k8s</a>
  - <a href="install/InstallRancher-2_6-Helm.md">Using helm to install Rancher 2.6 on k8s</a>

### Upgrade Rancher

   - <a href="install/upgrade-rancher-k8s.md">Upgrading Rancher and K8s</a>


## Configuration of cluster after it's up and running 


### Networking

   <a href="install/metalLB/README.md">Install and Configure MetalLB (on k3s)</a> - LoadBalancer that allows you to define a pool(s) of local IP addresses that can be automatically assigned/used by Applications deployed in Kubernetes 

   <a href="install/traefik/README.md">Install and configure Traefik (on k3s)</a> - This lab will show you how to create different type of Ingress rules using a few different sample applications

### Storage 

<a href="install/InstallLonghorn.md">Longhorn</a> - highly available persistent block storage for your Kubernetes workloads

<a href="install/InstallNFS-Provisioner">Install NFS Provisioner</a>

<a href="install/InstallNFS-Server">Installing NFS Server</a>

<a href="install/InstallNFS-Client">Installing NFS Client on Nodes</a>


## Adding Downstream Clusters to Rancher

    Now that you have Rancher up and running, it's very easy to create new clusters and import
    existing clusters.

<a href="install/InstallRKEfromRancher.md">Install Downstream RKE Cluster from Rancher</a>

<a href="install/ImportClusterRancher.md">Import existing Downstream Cluster</a>


## Deployments

<a href="deployments/Pi-hole">Pi-hole</a>  - Network-based ad-blocking software, and a custom DNS server. It blocks ads
from being displayed on the devices on your network. It uses DNS sinkholing and blocklists as a way of stopping internet
ads, malware, malvertising, etc. 

<a href="deployments/MQTT">MQTT</a> - Simple, light weight publish/subscribe message bus

<a href="deployments/NodeRed">NodeRed</a> - Browser based Development Enviroment that make it easy to connect various 
things together

<a href="deployments/InstallM5Stick">Install M5Stick</a> - Configuration and tools to setup your M5Stick

<a href="deployments/Novidrome">Install Novidrome</a> - Personal Media Server for stream audio