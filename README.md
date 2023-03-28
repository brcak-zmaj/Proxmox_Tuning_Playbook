<img src="https://raw.githubusercontent.com/geerlingguy/mac-dev-playbook/master/files/Mac-Dev-Playbook-Logo.png" width="250" height="156" alt="Mac Dev Playbook Logo" /> <img src="https://play-lh.googleusercontent.com/TT36Nsjyt0Yn8eyPAXuNK0bJsXmryP9ovsp7qdOy9sulYlr7v2Le5Ckf0I9S3AiaaXs=w240-h480-rw" width="250" height="156" alt="Mac Dev Playbook Logo" />

Brcak-Zmaj Proxmox Optimization Playbook
==========
                                              

Overview
--------

This is a quick and simple Playbook that was intended to bring a vanilla Proxmox to a Optimized and production ready server. This script installs useful utilities and packages that are helpful during day to day operations. Please submit pull requests..

> Idealy you would run this once and then any other time run with the --skip-tags=skip to save some time

> Note: I am providing code in the repository to you under an open source license. Because this is my personal repository, the license you receive to my code is from me and not my employer.
 

Plays
--------------------

Roles                             |  Description
----------------------------------|------------------------------------------------------------------------------------
Bash                              |  Configures bash rc and makes it pretty
Entropy                           |  Ensure Entropy Pools are Populated, prevents slowdowns whilst waiting for entropy
Fail2Ban                          |  Installs fail2ban and protects web UI
Journald                          |  Limit the size and optimise journald
KSM                               |  KSM Tuninig - Read about here https://pve.proxmox.com/wiki/Dynamic_Memory_Management
Log_Rotate                        |  Optimize for better performance and less disk useage 
Lynis                             |  Installs security Audit tool
NoSubBanner                       |  Removed annoying "You are not subscribed" banner from non-enterprise proxmox
VZDUMP                            |  Configures proxmox backup settings
ZFS                               |  Configure ZFS snapshots and Configure ZFS arch size
max-fs                            |  Increase limit for maximum system open files
max-watches                       |  Fix kernel bug - no space left on device
max-key                           |  Increase kernel max key limit
memory-tuning                     |  Tune kernel memory perameters 
max-key                           |  Increase kernel max key limit
bbr-congestion-control            |  Enable faster TCP/UDP algorithm
tcp-fast-open                     |  Read about here https://en.wikipedia.org/wiki/TCP_Fast_Open
enable-ipv4-forwarding            |
network-optimizations             | 


Packages & Utilities
------------

- pve-headers
- module-assistant
- aria2
- haveged
- apt-transport-https
- debian-archive-keyring
- ca-certificates
- curl
- zfsutils-linux
- axel
- build-essential
- dialog
- dnsutils
- dos2unix   
- gnupg-agent  
- grc 
- htop
- iftop
- iotop
- iperf
- ipset
- iptraf
- mlocate
- msr-tools
- nano
- net-tools
- software-properties-common
- sshpass
- unzip
- wget
- whois
- zip 
- ifupdown2
- systemd-timesyncd      
