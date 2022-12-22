---
layout: single
title: "[Day 11] Memory Forensics Not all gifts are nice "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

## Memory Forensics
### Process
At the simplest, a process is a running program.
User Process -> A process which got started by a user.
Background Process -> Processes launched automatically and managed by OS. 

## Volatility 
Is an open-source memory forensics toolkit written in Python. It can analyse memory dumps from Windos, Linux and Max OS. 
Some features: 

* List all processes that were running on the device at the time of the capture
* List active and closed network connections
* Use Yara rules to search for indicators of malware
* Retrieve hashed passwords, clipboard contents, and contents of the command prompt

If we don't know about the memory dump we can run: ```python3 vol.py -f workstation.vmem windows.info```
To list all running processes at the time of dump: ```python3 vol.py -f workstation.vmem windows.pslist```
To export specific binaries regarding a process: ```python3 vol.py -f workstation.vmem windows.dumpfiles --pid 4640```