## Installing SLES 15 SP2 on Raspberry Pi

In this lab, we are going to install and configure SLES 15 SP2 on a Raspberry Pi

The <a href="https://documentation.suse.com/sles/15-SP2/single-html/SLES-rpi-quick/#sec-rpi-platform">SUSE Documentation for the RaspberryPi Quickstart</a> is another awesome doc to get SLES running on the Pi

#### Prerequisite
Suggest:
 - Raspberry Pi 4 w/ 8gb Ram
 - SD Card

#### SLES 15 SP2 for ARM

###### Download the file SLES15-SP2-JeOS.aarch64-15.2-RaspberryPi-QU1.raw.xz from the link below

<a href="https://scc.suse.com/admin/products/1936">Download SLES and copy a registration code</a>


## Burning the image to an SDCard

You will need to burn this image to the SDcard.

### For Linux

Find  your SDcard by using the lsblk command
```
lsblk
```

Example
```

```

Use the information returned from lsblk for next command . In this example I'm using /dev/mmcblk0

```
xz -cd SLES15-SP2-JeOS.aarch64-15.2-RaspberryPi-QUI.raw.xz | sudo dd of=/dev/mmcblk0 bs=4096 iflag=fullblock status=progress
```

### For Windows

Download the following files

<a href="http://www.e7z.org">Easy 7-Zip</a>
<a href="http://sourceforge.net/projects/win32diskimager/">Win32 Disk Imager</a>


Use 7-zip to uncompress SLES15-SP2-JeOS.aarch64-15.2-RaspberryPi-QU1.raw.xz
Use Win32 Disk Imager to write the uncomressed image to the SDcard

### For Mac OSx

Use the tool available here:
<a href="https://downloads.raspberrypi.org/imager/imager_1.4.dmg">Raspian Image Burner</a>


*If you need additional help use the link below:

<a href="https://documentation.suse.com/sles/15-SP2/html/SLES-rpi-quick/art-rpiquick.html">Raspberry Pi on SLES</a>

## First Boot

**You will need a Monitor and Keyboard plugged into the Raspberry Pi for the first boot**

    Choose your local
    Select Keyboard
    Accept the licenses
    Select Timezone
    Enter a Password for the 'root' user
    Enable Wifi if needed (Ethernet is strongly suggested)

The System will now reboot

### Write down your Raspberry Pi IP address


```
Welcome to SUSE Linux Enterprise Server 15 SP2

eth01: 10.0.9.1 fe80::dea6:32ff:febb"6ffa
wlan0:
```

*At this point you can continue the rest of the setup via ssh

## Completing Install from your workstation

     ssh root@x.x.x.x

*Note the by default on SLES for Raspberry Pi, root is the only user created by default

Register your Server
```
SUSEConnect -r INTERNAL-USE-ONLY-xxxx-xxxx
```
```
Registering system to SUSE Customer Center
Using E-Mail: ###@###.com

Announcing system to https://scc.suse.com ...

Activating SLES 15.2 aarch64 ...
-> Adding service to system ...

Activating sle-module-basesystem 15.2 aarch64 ...
-> Adding service to system ...
-> Installing release package ...

Activating sle-module-server-applications 15.2 aarch64 ...
-> Adding service to system ...
-> Installing release package ...

Successfully registered system
```

*Note SLES for ARM is a different license than SLES for x86



### Update to the latest patches and install yast2


    zypper ref
    zypper up -y
    zypper in -y  -t pattern yast2_basis


### Install additional software we will need to the Labs

** Note 'which' is needed for the k3s install and 'sudo' is not installed by default
```
zypper in -y sudo which curl nmap git-core bash-completion
```

### Change the Hostname - Please use your name as part of the hostname
```
hostnamectl set-hostname pi-YOURNAME-1
```
### Disable the Firewall
```
systemctl disable --now firewalld
```
### Create a tux User and set a password
```
useradd -m -g users tux
passwd tux
```
### Reboot the workstation and login as tux
```
reboot
```
wait 30 seconds
```
ssh tux@x.x.x.x
```
