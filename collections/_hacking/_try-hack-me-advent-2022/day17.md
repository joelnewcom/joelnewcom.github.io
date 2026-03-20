---
layout: single
title: "[Day 17] Secure Coding Filtering for Order Amidst Chaos "
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Help with Regex
https://www.regular-expressions.info/quickstart.html


## Regex 101
```[a-z]```
The square brackets indicates to match one character to the defined character set within the brackets. 
The order within the brackets doesn't matter.  

**Operators**

The wildcard ```.```matches any character. 
The asterix ```*``` doesn't care if the preceding token matches or not.
The plus ```+``` make sure it matches at least once. 
The curly brackets ```{min, max}``` specifices the number of characters to match.
The question mark ```?``` denotes the preceding token is optional
The escape character ```\``` is used when you want to match a regex operator character.  

**Anchors**
The ```^``` and ```$``` denote the start and end of the string.

**Grouping**



### Examples
* To match alphanumeric and case insensitive: ```[a-zA-Z0-9]+``` (The plus indicates that we want to match a string regardless of its length)
* First part is composed of letters and we want it to match regardless if there are numbers thereafter:  ```^[a-zA-Z]+[0-9]*$```
* Just lowercase letters that are in between 3 and 9 characters in length: ```^[a-z]{3,9}$ ```
* Starts with 3 letters followed by any 3 characters, our pattern would be ```^[a-zA-Z]{3}.{3}$```
* match "www.tryhackme.com" and "tryhackme.com", but avoid ".tryhackme.com" ```^(www\.)?tryhackme\.com$``` ()

# Use HTML5 for input validation
```
1. <input type="text" id="uname" name="uname" pattern="[a-zA-Z0-9]+">
2. <input type="email" id="email" name="email" pattern=".+@tryhackme\.com">
```

```egrep 'regex_pattern_here' strings```

## 1
Filtering for Usernames: Alphanumeric, minimum of 6 characters, maximum of 12 characters, may consist of upper and lower case letters.
```^[a-zA-Z0-9]{6,12}$```

Filtering for Usernames: One username consists of a readable word concatenated with a number. What is it?
```^([a-zA-Z]+[0-9]+)$```

Filtering for Emails: Follows the form "local-part@domain" (without quotation marks); local-part is a random string, and the domain is in the form of "<domain name>.tld". All top-level domains (tld) are ".com"
```^.+@.+\.com$```

Filtering for URLs: Starts with either http or https; some of the URLs have "www", and a TLD should exist.
```^https?://.+(www\.)?.+\..+$```