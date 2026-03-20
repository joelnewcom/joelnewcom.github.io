---
layout: single
title: "[Day 7] CyberChef Maldocs roasting on an open fire"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

## CyberCheck
Is a webapplication to analyze data files. 
In this task we are going to analyze the attachment of previous Task. 

There were several steps to finally extract the flag:  

* Strings. (output only strings with minimum length of 258). It is obfuscated with "[_]" between every letter.
* Find / Replace. (with regex("[\[\]_\n]") .It shows that we start a Powershell with a base64 encoded content
* Drop bytes. (To output only the base64 encoded part)
* From Base64. It show a powershell script
* Decode Text. (UTF16LE) as powershell uses this encoding. 
* Find / Replace. to clean a bit up by removin obfuscate patterns
* Find / Replace. to replace simple strings we know the value (http)
* Extract URLs (Outputs only urls)
* Split (Split by @, as each url of suffixed with an @)
* Defang URL (Makes the URLs invalid/ unclickable)