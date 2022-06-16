The instructions below will give several options for installing NeuVector v5.

Install into existing cluster
    Option 1 - kubectl apply -f 
    
    Option 2 - helm install
    
    Option 3 - helm install using k3s helm operator
    Install K3s
    edit nv.yaml line 31 for your specific domain/ip address
    copy nv.yaml into /var/lib/rancher/k3s/server/manifests/nv.yaml
    go to http://yourspecificdomain/ip-address
    login with admin/admin
    
    Option 4 - Rancher Apps and Marketplace install

Install K3s + Neuvector on AWS using Terraform


