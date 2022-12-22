---
layout: single
title: "[Day 5] Brute-Forcing He knows when you're awake"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

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