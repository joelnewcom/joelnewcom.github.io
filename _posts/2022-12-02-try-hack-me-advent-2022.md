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






