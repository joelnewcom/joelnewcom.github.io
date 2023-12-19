---
layout: single
title: "[Day 3] Brute-forcing Hydra is Coming to Town"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Day 3
Is about feasibility of brute force and use of crunch and hydra to bruteforce a website.

# Theory - Counting the possibilities

Possibilities -> choices^digits

PIN code : 4 digits, 10 different values per digit 
-> 10^4 = 10'000 

Four character password with: 
UpperCase english letters (A-Z): 26 letters
LowerCase english letters (A-Z): 26 letters
Digits (0-9): 10 

Equals to 62 different choices. 
-> 62^4 = 14'776'336

# Solution
A website with a keypad is provided. The keypad displays 3 digits. 
Choices are: 0 -9, A, B, C, D, E, F = 16 choices

-> 16^3 = 4096

## Crunch
Crunch creates a list of all possible combinations: 

```crunch 3 3 0123456789ABCDEF -o 3digits.txt```

* 3 the minimum length of the generated password
* 3 the maximum length of the generated password
* 0123456789ABCDEF possible characters to generate the passwords
* -o 3digits.txt output file

# Hydra
hydra -l '' -P 3digits.txt -f -v 10.10.177.197 http-post-form "/login.php:pin=^PASS^:Access denied" -s 8000


* -l '' indicates that the login name is blank as the security lock only requires a password
* -P 3digits.txt specifies the password file to use
* -f stops Hydra after finding a working password
* -v provides verbose output and is helpful for catching errors
* 10.10.177.197 is the IP address of the target
* http-post-form specifies the HTTP method to use
* "/login.php:pin=^PASS^:Access denied" has three parts separated by :
  * /login.php is the page where the PIN code is submitted
  * pin=^PASS^ will replace ^PASS^ with values from the password list
  * Access denied indicates that invalid passwords will lead to a page that contains the text “Access denied”
* -s 8000 indicates the port number on the target

