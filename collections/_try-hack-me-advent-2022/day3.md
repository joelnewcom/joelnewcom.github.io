---
layout: single
title: "[Day 3] OSINT Nothing escapes detective McRed"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---
 
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