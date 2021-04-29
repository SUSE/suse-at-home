# Quick install of Rancher latest using Docker

### At the end of the Lab you will have:
* Rancher running in Docker

### Prerequisites:

- SUSE OS install
- Docker install and running

- <a href="InstallSLESonx86.md">SLES15 SP2 with Docker ready</a>



# Installing Rancher in docker

### 1) run docker command
```
sudo docker run --privileged -d --restart=unless-stopped \
-p 80:80 -p 443:443 \
rancher/rancher
```
