#cloud-config
resize_rootfs: true
write_files:
  - path: /root/bootstrap.sh
    permissions: 755
    content: ${bootstrap_content}
    encoding: b64
    owner: root:root    
ssh_authorized_keys:
  - ${ssh_key}
runcmd:
- sudo mkdir -p /var/lib/rancher/k3s/server/manifests
- curl -fSL https://get.k3s.io | INSTALL_K3S_CHANNEL=${channel} sh -
- sudo sh /root/bootstrap.sh