---
layout: single
title: "[Day 4] Scanning Scanning through the snow"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

You can scan a network with nmap:

* TCP SYN Scan. Return a list of live hosts and ports. Stealthy because it doesnt complete theTCP threewayhandshake ```nmap -sS MACHINE_IP```
* Ping Scan. ```nmap -sn MACHINE_IP```
* Operating System Scan. Gets the type of OS: ```nmap -O MACHINE_IP```
* Detecting Services. Returns running services of the host: ```nmap -sV MACHINE_IP```

Ports:
There are 0 - 65'536 Ports. They can be in: 
* Closed Ports: The host is not listening to the specific port.
* Open Ports: The host actively accepts a connection on the specific port.
* Filtered Ports: This indicates that the port is open; however, the host is not accepting connections or accepting connections as per certain criteria like specific source IP address.

You can scan a website for vulnerabilities. 
Run: ```nikto -host MACHINE_IP```

Pros are using: Nessus and Acunetix to identify loopholes in a system.


## Question
### What is running on the remote host?
![smbClient](/assets/images/tryhackme/Task-9-nmap.PNG)
```nmap -sV 10.10.154.0```

### What flag can you find after successfully accessing the Samba service?
Connect to SMB service on 10.10.85.223

![smbClient](/assets/images/tryhackme/Task-9-smb.PNG)

List shares:
```smbclient -L //10.10.85.223```

Open interactive shell
```smbclient "\\\10.10.85.223\admins" -U ubuntu%S@nta2022```
$ ls
$ cd
$ get

### What is the password for the username santahr?
![smbClient](/assets/images/tryhackme/Task-9-smb-interactive.PNG)