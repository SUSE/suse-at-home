## Setup SLES15 SP2 Image for KVM using the JeOS_KVM_and_XEN image

Let's be root
```sudo -s
```
Make a new tmp directory
```
mkdir vm-tmp
```
Copy the original kvm-and-xen image
```
cp pathto/SLES...qcow2 vm-tmp/original.qcow2
```

Create the 60G blank disk
```
export LIBGUESTFS_BACKEND=direct
qemu-img create -f qcow2 -o preallocation=metadata new.image 60G
```

Resize a disk for the new image
```
virt-resize --quiet --expand /dev/sda1 original.qcow2 new.image
```

overwrite the resized image as the qcow2 image
```
mv -v new.image rke.qcow2
```
Use the VMM tool to create a new domain from existing image
on first boot you need to peform some work to get a ready to build nodes

login as root
register with SUSEConnect
```
SUSEConnect -r regcode
SUSEConnect -p sle-module-containers/15.2/x86_64
```
```
zypper -n in -t pattern yast2_basis
zypper -n in sudo wget docker which vim iputils kernel-default
```
disable firewall?
```
systemctl stop --disable firewalld
```
enable Docker
```
systemctl enable --now docker
```
add tux user
```
yast2 users add username=tux password=linux
```
Reboot
