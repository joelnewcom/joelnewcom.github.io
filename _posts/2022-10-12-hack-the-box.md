---
layout: single
title:  "Hack the Box"
date:   2022-10-12 00:00:00 +0200
categories: hack-the-box
---

# Access
Pwnbox is a VM running by HackTHeBox. 
Via OpenVPN (OVPN) you can connect your own computer to the hackthebox network.

 
# HTB Academy
There are a lot of modules to learn.
MyWorkstation is a Parrot OS vm you can spin off

Docker Target: http://<ip>:<port> after spawning, i.e. http://157.245.40.149:30655. This is accessible from everywhere. 

If the task cannot be done with a docker image, the section will spin off a VM or multiple VMs.

# My Hackbox

## VirtualBox

Make sure you enabled shared-clipboard option. Otherwise you cannot copy from host to VM and vice versa.
![getFlag](/assets/images/hackthebox/virtualbox-shared-clipboard.png)


## Hacking Lab Live CD
I am using the [latest Hacking-Lab liveCD](https://livecd.hacking-lab.com/) on [VirtualBox](https://www.virtualbox.org/wiki/Downloads).
based on a 64-bit Kali Linux system.

Username = hacker 
Password = compass

## Parrot OS
VM networkmodus: NAT
No password for admin account.

Its pain in the ass to change keyboard layout after every restart.

```
$sudo openvpn starting_point_saywhatagain.ovpn
```

Couldnt ping or nmap the target either...


* Now trying with TCP VPN connection instead of UDP.
* Connection didn't even show up. So I soft-resetted the whole Meow box.
Always the same. VPN connection is working but target is not pingable. 


31.10.2022 nothing fucking works here.

## Kali linux
Same behaviour as Parrot.

# Starting Point Challenges 
## Meow
In my vm: Open browser a browse to Meow challenge. 

Downloading the VPN file to my Desktop and run:

```
/home/hacker  openvpn /home/hacker/Desktop/starting_point_saywhatagain.ovpn
```

What tool do we use to test our connection to the target with an ICMP echo request? 
ping

What is the name of the most common tool for finding open ports on a target? 
nmap

using nmap against the target IP address gives me:
...

It tells me the target is not running. Investigated some VPN issues until I decided to switch to a plain parrot security vm.

## Fawn
using a pwnbox and starting point vpn server located in us -> It works

Ping is an ICMP echo request.

Do a simple portscan on target:
![getFlag](/assets/images/hackthebox/fawn_nmap-default.png)

Check OS info with -sV options
![getFlag](/assets/images/hackthebox/fawn-nmap-os-info.png)

Getting the flag
![getFlag](/assets/images/hackthebox/fawn_get_flag.png)

FTP (File transfer protocol) works normally on port 21.

## Dancing
Targets IP: 10.129.189.104

Trying again with ovpn, but this time tacking US starting point.
It worked. 

SMB (Server Message Block) works on port 445.

Doing nmap scan on target: 
```
nmap -sV 10.129.189.104
```
-sV: Probe open ports to determine service/version info

```
smbclient -L 10.129.189.104
```


