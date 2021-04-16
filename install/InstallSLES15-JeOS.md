# Setup SLES15 SP2 Image for KVM using the JeOS_KVM_and_XEN image

### At the end of the Lab you will have:
- SLE 15 SP2 JeOS Instance running under KMV

# Installing SLES

### 1) Become root
```sudo -s
```
### 2) Make a new tmp directory
```
mkdir vm-tmp
```
### 3) Copy the original kvm-and-xen image
```
cp pathto/SLES...qcow2 vm-tmp/original.qcow2
```

### 4) Create the 60G blank disk
```
export LIBGUESTFS_BACKEND=direct
qemu-img create -f qcow2 -o preallocation=metadata new.image 60G
```

### 5) Resize a disk for the new image
```
virt-resize --quiet --expand /dev/sda1 original.qcow2 new.image
```

### 6) overwrite the resized image as the qcow2 image
```
mv -v new.image rke.qcow2
```
### 7) Use the VMM tool to create a new domain from existing image
on first boot you need to preform some work to get a ready to build nodes


### 8) Register with SUSEConnect
```
SUSEConnect -r regcode
SUSEConnect -p sle-module-containers/15.2/x86_64
```

### 9) Install needed packages

```
zypper -n in -t pattern yast2_basis
zypper -n in sudo wget docker which vim iputils kernel-default
```
### 10) Disable firewall?
```
systemctl stop --disable firewalld
```
### 11) Enable Docker
```
systemctl enable --now docker
```
### 12) Add tux user
```
yast2 users add username=tux password=linux
```
### 13) Reboot
