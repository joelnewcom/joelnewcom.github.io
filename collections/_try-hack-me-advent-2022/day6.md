---
layout: single
title: "[Day 6] Email Analysis It's beginning to look a lot like phishing"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

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

With ```sha256sum``` we calculate the checksum of the attachment to then search it on virusTotal: https://www.virustotal.com
![hydra -f](/assets/images/tryhackme/day6/virustotal.PNG)

and we can also check on https://labs.inquest.net/
![hydra -f](/assets/images/tryhackme/day6/Inquest.PNG)