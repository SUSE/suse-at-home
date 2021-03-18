### Quick install of Rancher latest

This lab is a quick install of Rancher using docker.

Requires:
- <a href="InstallSLESonx86.md">SLES15 SP2 with Docker ready</a>

This command will download and run the rancher installer
Then install K3s and run Rancher server
```
sudo docker run --privileged -d --restart=unless-stopped \
-p 80:80 -p 443:443 \
rancher/rancher
```
