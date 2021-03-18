### Setup cloud-init for KVM

#### This doc will outline how to setup a KVM instance from the SLE15SP2 JeOS Openstack image

On the host create a new directory in your kvm images default directory
```
mkdir /var/lib/libvirt/images/<vmName>
```
Change to that directory
```
cd /var/lib/libvirt/images/<vmName>
```
Create meta-data file
```
vi meta-data
```
Append:
```
instance-id:  <vmName>
local-hostname: <vmName>
```
Save and close
```
:wq
```
We need to modify the image so we can login (among other things)
Let's create a user-data file
```
vi user-data
```
Append:
```
#cloud-config
# set locale
locale: en_US.UTF-8
# set timezone
timezone: America/Denver
# Set FQDN
fqdn: ${fqdn}
# set root password
chpasswd:
  list: |
    root:linux
    ${username}:${password}
  expire: False
ssh_authorized_keys:
${authorized_keys}
# need to disable gpg checks because the cloud image has an untrusted repo
zypper:
  repos:
${repositories}
  config:
    gpgcheck: "off"
    solver.onlyRequires: "true"
    download.use_deltarpm: "true"

# need to remove the standard docker packages that are pre-installed on the
# cloud image because they conflict with the kubic- ones that are pulled by
# the kubernetes packages
packages:
${packages}

runcmd:
  # Since we are currently inside of the cloud-init systemd unit, trying to
  # start another service by either `enable --now` or `start` will create a
  # deadlock. Instead, we have to use the `--no-block-` flag.
  - [ systemctl, enable, --now, --no-block, haproxy ]
#${register_scc}
#  - [ zypper, in, --force-resolution, --no-confirm, --force, podman, kernel-default, cri-o, kubernetes-kubeadm,  kubernetes-client, skuba-update ]
#  - [ reboot ]
  - SUSEConnect --cleanup
  - SUSEConnect -d
  - SUSEConnect --url ${rmt_server_url}
  - SUSEConnect -p sle-module-containers/15.1/x86_64
  - SUSEConnect -p caasp/4.0/x86_64 --url ${rmt_server_url}
  - zypper --non-interactive install nfs-client
  - zypper --non-interactive update
#  - reboot


bootcmd:
  - ip link set dev eth0 mtu 1400

final_message: "The system is finally up, after $UPTIME seconds"
```
Save this file
```
:wq
```
```
genisoimage -output ci.iso -volid cidata -joliet -rock user-data meta-data
```
```
mkisofs -J -l -R -V "cidata" -iso-level 4 -o ci.iso user-data meta-data
```
boot the image
```
qemu-kvm -name <vmname> \
 -m 8096 \
 -hda <vmname>-disk.qcow2 \
 -cdrom ci.iso \
 -netdev bridge,br=virbr0,id=net0 \
 -device virtio-net-pci,netdev=net0 \
 -display sdl
 ```
