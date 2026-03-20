---
layout: single
title: "[Day 13] Packet Analysis Simply having a wonderful pcap time "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

## Wireshark
To get an overview of the captured traffic you can navigate to "Statistics" -> "Protocol Hierachy" 
![Wireshark statisik](/assets/images/tryhackme/day13/wireshark-statistik.PNG)

As well "Statistics" -> "Conversations". This helps to identify IPs and port used for conversations. 

![Wireshark DNS Query](/assets/images/tryhackme/day13/wireshark-dns-query.PNG)
filter all pakets via "dns". This shows the used domains

![Wireshark HTTP Query](/assets/images/tryhackme/day13/wireshark-export-http.PNG)
Filter by http traffic shows us that one downloaded two files

The files can be exported: 
![Wireshark Export HTTP](/assets/images/tryhackme/day13/wireshark-export-http.PNG)

Lets take the sha265 checksum of the file.
![sha265](/assets/images/tryhackme/day13/sha256sum-of-files.PNG)

Lets check the hash on virustotal
![vt](/assets/images/tryhackme/day13/check-sum-on-vt.PNG)