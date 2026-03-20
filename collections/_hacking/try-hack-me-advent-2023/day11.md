---
layout: single
title: "[Day 11] Active Directory Jingle Bells, Shadow Spells"
header:
  teaser: "/assets/images/hacking-teaser.JPG"
---

# Day 11
is about actie directory

# Theory

## Windows Hello for business (WHfB)
Windows Hello can connect a PIN or biometrics to a public/private key par.

In AD, each new user device will have its public key in the ```msDS-KeyCredentialLink``` attribute.


## Shadow credential attack

### Whisker
Once we have a vulnerable user, we can run the add command from Whisker to simulate the enrollment of a malicious device, updating the msDS-KeyCredentialLink attribute.
