---
layout: single
title:  "Try hack me"
date:   2022-12-02 00:00:00 +0200
categories: try-hack-me
---

# Task #1 Introduction
Read through the awesomes prices and notice how each task gets also a walkthrough of famous cyber security streamers.
 Click "Completed" and task is done. 
 
# Task #2 Short Tutorial & Rules
There is a link to a tutorial how to connect via open VPN into your tryhack me room network.
I did the tutorial by running my ParrotOS within virtualBox and open tryhackme in the browser there.
You need to download a .ovpn file and start it with: ```sudo openvpn Desktop/saywhatagain.ovpn```
Then you would need to start the target machine. Its IP address is printed on the page and you only need to 
put the IP into the browsers addressbar and you get the flag. 

![Cyber kill chain](/assets/images/tryhackme/tutorial-target-ip.PNG)

![Cyber kill chain](/assets/images/tryhackme/tutorial-target-ip-in-browser.PNG)


There are also rules diplayed like don't share the flags and don't hack other users..

# Task #3 Our socials
I joined the Discord channel and twitter

# Task #4 Subscribing, TryHackMe for Business & Christmas Swag! 
Yout get 20% off personal annual subscriptions until 06.12.2022. Thinking about it.

# Task #5 Nightmare Before Elfmas - The Story 
First story of the Elf McSkidy. Shes working in a SOC team and someone was in their office. 
Their gift shop website got defaced with a puzzle to solve. If they solve it they would know who it was.

# Task #6 [Day 1] Frameworks Someone's coming to town!
Explenation about different security frameworks

## NIST Cyber security framework (CSF)
Focuses around these five functions: Identify -> Protect -> Detect -> Respond -> Recover.
This helps an organization to prioritize their investment into cybersecurity.

## ISO 27000 Series
ISO 270001 and ISO 270002 helps to implement an information security management system (ISMS). 
These standards are great when you assess an institution or company if they meet cyber security requirements.

## MITRE ATT&CK Framework
Helps to identify an adversary by looking at their Tactics, Techniques and Procedures (TTPs).
Its a mapping of techniques agains attack phases. 

## Cyber Kill Chain
Describes 7 stages of an attack. This helps to understand the adversary's tactic.
![Cyber kill chain](/assets/images/tryhackme/cyber-kill-chain.bmp)

## Unified Kill Chain (UKC)
Unification of MITRE ATT&CK and Cyber Kill Chain. It describes 18 phases of an attack based on TTPs of an adversary.
The 18 phases split into 3 cycles:

In, Through and Out

To solve this task, you would need to sort the 18 attack phases of ULC into the right order. 

# Task #7 [Day 2] Log Analysis Santa's Naughty & Nice Log 
Common log file locations: 

## Windows 
Has a built in application called "Event Viewer". 

|Category       |Description                            |Example|
|---------------|---------------------------------------|-------|
|Application    |Related to applications                |The service "tryhackme.exe" was restarted.|
|Security       |Related to OS Security                 |User "cmnatic" successfully logged in.|
|Setup          |Related to OS maintenance (updates)    |The system must be restarted before "KB10134" can be installed.|
|System         |Related to OS. USB plugged-in, On/Off  |The system unexpectedly shutdown due to power issues.|

## Linux (Ubuntu/Debian)
Operating system logs and often software specific logs are located on ```/var/log```
Important files in ```/var/log```

|Category           |Description                                    | File (Ubuntu) |Example|
|-------------------|-----------------------------------------------|---------------|-------|
|Authentication     |Related to logins                              |auth.log       |Failed password for root from 192.168.1.35 port 22 ssh2.|
|Package management |Related to installations                       |dpkg.log       |2022-06-03 21:45:59 installed neofetch.|
|Syslog             |Related to OS (crontabs, services start/stop   |syslog         |2022-06-03 13:33:7 Finished Daily apt download activities..|
|Kernel             |Related to kernel events, USB, networking      |kern.log       |2022-06-03 10:10:01 Firewalling registered|

## Looking through Log files
Splunk is known as SIEM (Security Information and Event management).
Is super useful but hard to setup and super expensive.

### Grep 101
Use ```pwd``` to print out your current working directory
Use ```cd``` and ```ls``` to move around folder structures. 
Use ```ls -lah``` to list files and directories. 

Use ```grep "192.168.1.30" access.log``` to look for the IP in access.log in current directory. 
Use ```grep -i``` for insensitiv search, use ```grep -E thm|tryhackme``` for regex ("htm" or "tryhackme"), use ```grep -r "what" mydirectory``` to search recursively within the files in the specified directory. 
Use ```man grep``` to get more options. 

## Questions
To fulfil this task we need to connect to the target machine via ssh. 
They provide IP address, Username and password.

Run ```sh {username}@{ip address}```
They will ask for the password when connection is available.

For looking what was stolen I used
```rep "HTTP/1.1\" 200" webserver.log``` to get all successful calls. 

To get the flag I used ```grep -r "THM{" .```

# Task #8 [Day 3] OSINT Nothing escapes detective McRed
## OSINT techniques
### Google dorks
* inurl: Searches text in indexed URLs. For example, ```inurl:hacking``` will fetch all URLs containing the word "hacking".
* filetype: Searches by file extensions. For example, ```filetype:pdf "hacking"``` will bring all pdf files containing the word "hacking". 
* site: Searches URLs for the specified domain. For example, ```site:tryhackme.com``` will bring all the indexed URLs from  tryhackme.com.
* cache: Get the latest cached version by the Google search engine. For example, ```cache:tryhackme.com```.

### WhoIs lookup
PII info about registrar of a domain. 

### Robots.txt
Every websites  provides a robots.txt file under its root folder like: https://www.google.com/robots.txt
robots.txt includes information for search engines. Telling them what to index and what not.

### Breached Database Search 
https://haveibeenpwned.com/

### GitHub Repos
Victim might exposed sourcecode on github.

## Questions
1. Check https://who.is/whois/santagift.shop
2. Clone repo on https://github.com/muhammadthm/SantaGiftShop and answer all the questions. 

# Task #9 [Day 4] Scanning Scanning through the snow
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


# Task 10 [Day 5] Brute-Forcing He knows when you're awake

We are going to dictionary attack an account. 

First scan the target via ```nmap -sS 10.10.93.183``` -sS = TCP SYN Scan technique
![hydra -f](/assets/images/tryhackme/day5/nmap.PNG)

THC Hydra is am commandline tool which understands SSH, VNC, FTP, POP*, IMAP, SMTP and others. 

We run the command: ```hydra -l alexander -P /usr/share/wordlists/rockyou.txt ssh://10.10.93.183 -V```
This will find us the password for ssh user alexander. 

Next task is to find a VNC password on the target. As VNC doesn't use username we omit it: 
```hydra -P /usr/share/wordlists/rockyou.txt vnc://10.10.93.183 -V```
This took quite long. 
Somehow it didn't stop after it found a password. 
I run again with ```hydra -P /usr/share/wordlists/rockyou.txt vnc://10.10.93.183 -f``` which should explicit stop after the first match.

![hydra -f](/assets/images/tryhackme/day5/hydra-f.PNG)

Eventually I could vnc login with Remmina into the target. 

# Task 11 [Day 6] Email Analysis It's beginning to look a lot like phishing

## OSINT
Using https://emailrep.io tells you something about a sender address reputation. ("From" and "Return-Path")

| Tool              | 	Purpose | 
| ------------------| ----------| 
| VirusTotal        | A service that provides a cloud-based detection toolset and sandbox environment.| 
| InQuest           | A service provides network and file analysis by using threat analytics. (https://labs.inquest.net/)| 
| IPinfo.io         | A service that provides detailed information about an IP address by focusing on geolocation data and service provider.| 
| Talos Reputation  | An IP reputation check service is provided by Cisco Talos.| 
| Urlscan.io        | A service that analyses websites by simulating regular user behaviour.| 
| Browserling       | A browser sandbox is used to test suspicious/malicious links.| 
| Wannabrowser      | A browser sandbox is used to test suspicious/malicious links.| 


By running ```emlAnalyzer -i Urgent\:.eml --header --html -u --text --extract-all``` we can extract the attachment without opening it. 

With ```sha256sum``` we calculate the checksum of the attachement to then search it on virusTotal: https://www.virustotal.com
![hydra -f](/assets/images/tryhackme/day6/virustotal.PNG)

and we can also check on https://labs.inquest.net/
![hydra -f](/assets/images/tryhackme/day6/Inquest.PNG)
 