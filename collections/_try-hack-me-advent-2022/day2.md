---
layout: single
title: "[Day 2] Log Analysis Santa's Naughty & Nice Log "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---
 
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