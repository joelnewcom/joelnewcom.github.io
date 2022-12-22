---
layout: single
title: "[Day 12] Malware Analysis Forensic McBlue to the REVscue!"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

## Malware behaviour
* Network connections -> A malware tends to make connections to a host to get instructions, download payloads etc. Or to do lateral movement.  
Registry Run Keys -> Allows binaries to be automatically be executed when a user logs in or on boot up.
File manipulation -> Everyprogram needs to have a set of files to work.
 
## Working with malware
Always assume the malware infects your computer. 
Use a sandbox to run a malware. 

## FlareVM
Is a windows vm to analyse how the malware behaves on windows. 

### Detect It Easy
Provides infos about the binary. For example we see that the binary is packed with UPX. This obfuscated binary is hard to analyse so we need to unpack it first.  
![Detect it easy](/assets/images/tryhackme/day12/detect-it-easy.PNG)

### CAPA
Is a static analysis tool. 
![Unpack and capa](/assets/images/tryhackme/day12/unpack%20and%20capa.PNG)

### ProcMon
Is a Windows tool that shows real-time registry, file system, and process/thread activity
![Registry run key](/assets/images/tryhackme/day12/registry-run-key-modification.PNG)

![Startup persistance](/assets/images/tryhackme/day12/Startup-persistence.PNG)

![Network connectivity](/assets/images/tryhackme/day12/network-connectivity.PNG)