# Installing SLES 15 SP3 on Raspberry Pi

### At the end of the Lab you will have:
* Raspberry Pi 4 running SLES 15 SP3


The <a href="https://documentation.suse.com/sles/15-SP3/single-html/SLES-rpi-quick/#sec-rpi-platform">SUSE Documentation for the Raspberry Pi Quickstart</a> is another awesome doc to get SLES running on the Pi

#### Prerequisite
Suggest:
 - Raspberry Pi 4 w/ 8gb Ram
 - Micro SD Card
 - Optional USB 3 boot drive

# Download SLES 15 SP3 for Raspberry Pi (Arm)

### 1) Download the file SLES15-SP3-JeOS.aarch64-15.3-RaspberryPi-GM.raw.xz from the link below - make sure you choose Stable Release 15 SP3 and Architecture Arm

<a href="https://www.suse.com/download/sles/">Download SLES and copy a registration code</a>

# Burning the image to a micro SD Card

You will need to burn this image to the micro SD card.

## For Linux

### 1) Find  your micro SD card by using the lsblk command
```
lsblk
```

Example
```
```

### 2) Use the information returned from lsblk for next command.
 In this example I'm using /dev/mmcblk0

```
xz -cd SLES15-SP3-JeOS.aarch64-15.3-RaspberryPi-GM.raw.xz | sudo dd of=/dev/mmcblk0 bs=4096 iflag=fullblock status=progress
```

## For Windows

### 1) Download the following files

<a href="http://www.e7z.org">Easy 7-Zip</a>
<a href="http://sourceforge.net/projects/win32diskimager/">Win32 Disk Imager</a>


### 2) Use 7-zip to uncompress SLES15-SP3-JeOS.aarch64-15.3-RaspberryPi-GM.raw.xz
### 3) Use Win32 Disk Imager to write the uncomressed image to the SDcard

## For Mac OSx

### 1) Use the tool available here:
<a href="https://downloads.raspberrypi.org/imager/imager_1.6.2.dmg">Raspberry Pi Imager</a>

### 2) Burn image to micro SD card


*If you need additional help use the link below:

<a href="https://documentation.suse.com/sles/15-SP3/html/SLES-rpi-quick/art-rpiquick.html">SLES for Arm on Raspberry Pi</a>

# SLES First Boot

**You will need a Monitor and Keyboard plugged into the Raspberry Pi for the first boot**

### 1) Run through the first boot script answering the following questions:

    Choose your local
    Select Keyboard
    Accept the licenses
    Select Timezone
    Enter a Password for the 'root' user
    Enable Wifi if needed (Ethernet is strongly suggested)

The System will now reboot

### 2) Write down your Raspberry Pi IP address


```
Welcome to SUSE Linux Enterprise Server 15 SP3

eth01: 10.0.9.1 fe80::dea6:32ff:febb"6ffa
wlan0:
```

*At this point you can continue the rest of the setup via ssh

# Completing Install from your workstation

### 1) Connect to server as root

     ssh root@x.x.x.x

*Note the by default on SLES for Raspberry Pi, root is the only user created by default

### 2) Register your Server
```
SUSEConnect -r INTERNAL-USE-ONLY-xxxx-xxxx
```
Example
```
Registering system to SUSE Customer Center
Using E-Mail: ###@###.com

Announcing system to https://scc.suse.com ...

Activating SLES 15.3 aarch64 ...
-> Adding service to system ...

Activating sle-module-basesystem 15.3 aarch64 ...
-> Adding service to system ...
-> Installing release package ...

Activating sle-module-server-applications 15.3 aarch64 ...
-> Adding service to system ...
-> Installing release package ...

Successfully registered system
```

*Note SLES for ARM is a different license than SLES for x86



### 3) Update to the latest patches and install yast2


    zypper ref
    zypper up -y
    zypper in -y  -t pattern yast2_basis


### 4) Install additional software we will need to the Labs

** Note 'which' is needed for the k3s install and 'sudo' is not installed by default
```
zypper in -y sudo which curl nmap git-core bash-completion
```

### 5) Change the Hostname - Please use your name as part of the hostname
```
hostnamectl set-hostname pi-YOURNAME-1
```
### 6) Disable the Firewall
```
systemctl disable --now firewalld
```
### 7) Create a tux User and set a password
```
useradd -m -g users tux
passwd tux
```
### 8) Reboot the workstation and login as tux
```
reboot
```
wait 30 seconds

### 9) connect to server as tux

```
ssh tux@x.x.x.x
```
