---
layout: single
title: "[Day 7] Log analysis ‘Tis the season for log chopping!"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Day 7 analyse logs
Analyse logs of format: 

```
timestamp - source_ip - domain:port - http_method - http_uri - status_code - response_size - user_agent
```

An example: 
```
[2023/10/25:16:17:14] 10.10.140.96 storage.live.com:443 GET / 400 630 "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36"
```

## Get the first five connections made by 10.10.140.96.
```
grep 10.10.140.96 access.log | head -n 5
```

## Get the list of unique domains accessed by all workstations.
```
cut -d ' ' -f3 access.log | cut -d ':' -f1 | sort | uniq
```

- cut will split each line by -d delimiter and select the third columns (-f1,3,6 if you want to select multiple)
- uniq only keeps distinct values. Though the list needs to be sorted first

## Display the connection count made on each domain.
Same as above, but uniq can count and then we sort by this value. 
```
cut -d ' ' -f3 access.log | cut -d ':' -f1 | sort | uniq -c | sort -nr
```


# Challenge

## How many unique IP addresses are connected to the proxy server?
```
cut -d ' ' -f2 access.log | sort | uniq
```

## How many unique domains were accessed by all workstations?
```
cut -d ' ' -f3 access.log | cut -d ':' -f1 | sort | uniq | wc
```

## What status code is generated by the HTTP requests to the least accessed domain?
```
cut -d ' ' -f3 access.log | cut -d ':' -f1 | sort | uniq -c | sort -nr | tail -5
grep partnerservices.getmicrosoftkey.com access.log
```

## Based on the high count of connection attempts, what is the name of the suspicious domain?
```
cut -d ' ' -f3 access.log | cut -d ':' -f1 | sort | uniq -c | sort -nr | head -10
```

## What is the source IP of the workstation that accessed the malicious domain?
```
grep frostlings.bigbadstash.thm access.log
```

## How many requests were made on the malicious domain in total?
```
grep frostlings.bigbadstash.thm access.log | wc
```

## Having retrieved the exfiltrated data, what is the hidden flag?
```
grep frostlings.bigbadstash.thm access.log | cut -d ' ' -f5 | cut -d '=' -f2 | base64 -d
```
