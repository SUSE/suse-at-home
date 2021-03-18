# SUSE at Home

## Objectives

* Give a hands-on experience with some of our newer technologies including Kubernetes and Rancher

* Provide a base of SLES, Kubernetes and Rancher that you can then deploy applications to make your life better


## What's here

### Install - /install 
    All information on how go from metal until you have SLES, Kubernetes (RKE or K3s) and Rancher 
    
    This is where you should start...even if you have SLES install just look. Make sure you have the proper packages intalled and enabled, turn off or open up the fireware and make sure you setup the ssh-keys.

### SLES Install
    Pick a one of the methods below to install SLES

- Installation of SLES15 SP2 on <a href="install/InstallSLESonx86.md"> x86_64</a>
- Installation of SLES15 SP2 on Raspberry Pi <a href="install/InstallSLESonRPi.md">aarch64</a>

- <a href="install/InstallSLE15-JeOS-KVM-Cloud-init.md">Setup cloud-init for KVM installs</a>
- <a href="https://github.com/zoopster/junk/tree/master/tf-sles15-cloudinit">Terraform install of SLES on KVM</a>



### Rancher
    Now that we have an OS we have a couple of options for Rancher.

    Rancher normally runs on top of Kubernetes. You pick any of our Kubernetes (RKE, RKE2 or K3s) and then install Rancher via helm.  

- In a production world, we would <a href="install/InstallRKEonSLES15x86_64.md">install RKE on top SLES</a> and then follow the instructions for installing <a href="install/InstallRancher-Helm.md">Rancher using helm to install Rancher on k8s</a>

- Since this is just a system at home we could run the might lighter version of Kubernetes by <a href="install/InstallK3s.md">Installing K3s</a> and then follow the instructions for installing <a href="install/InstallRancher-Helm.

- You could also just run Rancher as a Service under linux by following the <a href="install/InstallRancher-Rancherd.md">Quick install of Rancher on RKE2 using Rancherd</a>

- Or you could just run Rancher under docker by following <a href="install/InstallRancher-Docker.md">Quick install of Rancher using docker</a>

- Rancher
  - <a href="install/InstallRancher-Docker.md">Quick install of Rancher using docker</a>
  - <a href="install/InstallRancher-Rancherd.md">Quick install of Rancher on RKE2 using Rancherd</a>
  - <a href="install/InstallRancher-Helm.md">Using helm to install Rancher on k8s</a>

### Installing Kubernetes

- RKE - Full Blown Kubernetes
  - <a href="install/InstallRKEonSLES15x86_64.md">Simple single-node RKE install on SLES15 SP2 x86_64</a>
- RKE2 (Rancher Government)
  - <a href="install/InstallRKE2onSLE.md">Install RKE2 (RKE government) on SLES15 SP2 x86_64</a>
- K3s - Lightwight w/ batteries 
  - <a href="install/InstallK3s.md">Install K3s</a>

## Configuration 

### Networking

   <a href="install/InstallMetalLB.md">Configure MetalLB</a> - LoadBalancer that allows you to assign a group of local IP addresses to be used by Applications running unser Kubernetes

### Storage 

Longhorn
<a href="install/Lab-LocalStorage">Configure local storage (K3s)</a>

Mounting NFS in a Deployment

## Deployments

Pi-hole  
MQTT 
NodRed


